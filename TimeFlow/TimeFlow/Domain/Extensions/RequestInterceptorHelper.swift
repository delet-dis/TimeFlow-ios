//
//  RequestInterceptorHelper.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Alamofire
import Foundation
import SwiftUI

class RequestInterceptorHelper: RequestInterceptor {
    private var saveTokenUseCase: SaveTokensUseCase
    private var refreshTokenUseCase: RefreshTokenUseCase
    private var logoutUseCase: LogoutUseCase
    private var getTokenUseCase: GetTokenUseCase
    private var newToken = ""

    init(
        saveTokenUseCase: SaveTokensUseCase,
        refreshTokenUseCase: RefreshTokenUseCase,
        logoutUseCase: LogoutUseCase,
        getTokenUseCase: GetTokenUseCase
    ) {
        self.saveTokenUseCase = saveTokenUseCase
        self.refreshTokenUseCase = refreshTokenUseCase
        self.logoutUseCase = logoutUseCase
        self.getTokenUseCase = getTokenUseCase
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        NetworkingKeysEnum.allCases.forEach { entry in
            if entry.rawValue == urlRequest.url?.absoluteString {
                var adaptedRequest = urlRequest
                adaptedRequest.setValue("Bearer \(newToken)", forHTTPHeaderField: entry.rawValue)
                completion(.success(adaptedRequest))
            }
            else {
                completion(.success(urlRequest))
            }
        }
    }

    func retry(
        _ request: Request, for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        getTokenUseCase.execute { [self] result in
            switch result {
            case .success(let token):
                if let response = request.task?.response as? HTTPURLResponse,
                   response.statusCode == NetworkingConstants.wrongAccessToken {
                    refreshTokenUseCase.execute { [weak self] result in
                        switch result {
                        case .success(let result):
                            self?.newToken = result.accessToken
                            self?.saveTokenUseCase.execute(
                                authToken: result.accessToken,
                                refreshToken: result.refreshToken
                            ) { [weak self] result in
                                switch result {
                                case .success:
                                    completion(.retry)
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        case .failure(let error):
                            //TODO: LogOut
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                // TODO: LogOut
                print(error)
            }
        }
    }
}
