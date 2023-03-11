//
//  RequestInterceptor.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Alamofire
import Foundation

class RequestInterceptor: Alamofire.RequestInterceptor {
    private let saveTokensUseCase: SaveTokensUseCase
    private let getTokensUseCase: GetTokensUseCase
    private let refreshTokenUseCase: RefreshTokenUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        saveTokensUseCase: SaveTokensUseCase,
        getTokensUseCase: GetTokensUseCase,
        refreshTokenUseCase: RefreshTokenUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.saveTokensUseCase = saveTokensUseCase
        self.getTokensUseCase = getTokensUseCase
        self.refreshTokenUseCase = refreshTokenUseCase
        self.logoutUseCase = logoutUseCase
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let urlAsString = urlRequest.url?.absoluteString else {
            completion(.success(urlRequest))

            return
        }

        if NetworkingKeysEnum.allCases.contains(where: { $0.rawValue.contains(urlAsString) }) {
            getTokensUseCase.execute(tokenType: .auth) { result in
                switch result {
                case .success(let token):
                    var adaptedRequest = urlRequest
                    adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                    completion(.success(adaptedRequest))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(urlRequest))
        }
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        switch request.response?.statusCode {
        case NetworkingConstants.wrongAccessToken:
            getTokensUseCase.execute(tokenType: .refresh) { [weak self] result in
                switch result {
                case .success(let refreshToken):
                    self?.refreshTokenUseCase.execute(
                        refreshTokenRequest: .init(refreshToken: refreshToken)
                    ) { result in
                        switch result {
                        case .success(let response):
                            self?.saveTokensUseCase.execute(
                                authToken: response.accessToken,
                                refreshToken: response.refreshToken
                            ) { result in
                                switch result {
                                case .success:
                                    completion(.retry)
                                case .failure(let error):
                                    completion(.doNotRetryWithError(error))

                                    self?.logoutUseCase.execute(token: "")
                                }
                            }
                        case .failure(let error):
                            completion(.doNotRetryWithError(error))

                            self?.logoutUseCase.execute(token: "")
                        }
                    }
                case .failure(let error):
                    completion(.doNotRetryWithError(error))

                    self?.logoutUseCase.execute(token: "")
                }
            }

        case NetworkingConstants.wrongRefreshToken:
            completion(.doNotRetryWithError(error))

            logoutUseCase.execute(token: "")

        default:
            completion(.doNotRetryWithError(error))
        }
    }
}
