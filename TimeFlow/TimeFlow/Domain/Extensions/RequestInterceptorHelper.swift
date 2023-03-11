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
    private var saveTokensUseCase: SaveTokensUseCase
    private var logoutUseCase: LogoutUseCase
    private var getTokensUseCase: GetTokensUseCase
    private var newToken = ""

    init(
        saveTokensUseCase: SaveTokensUseCase,
        getTokensUseCase: GetTokensUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.saveTokensUseCase = saveTokensUseCase
        self.getTokensUseCase = getTokensUseCase
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
            var adaptedRequest = urlRequest
            adaptedRequest.setValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
            completion(.success(adaptedRequest))
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
        if request.response?.statusCode == NetworkingConstants.wrongAccessToken {}

//        GetTokensUseCase.execute { [self] result in
//            switch result {
//            case .success(let token):
//                if let response = request.task?.response as? HTTPURLResponse,
//                   response.statusCode == NetworkingConstants.wrongAccessToken {
//                    refreshTokenUseCase.execute { [weak self] result in
//                        switch result {
//                        case .success(let result):
//                            self?.newToken = result.accessToken
//                            self?.saveTokenUseCase.execute(
//                                authToken: result.accessToken,
//                                refreshToken: result.refreshToken
//                            ) { [weak self] result in
//                                switch result {
//                                case .success:
//                                    completion(.retry)
//                                case .failure(let error):
//                                    print(error)
//                                }
//                            }
//                        case .failure(let error):
//                            //TODO: LogOut
//                            print(error)
//                        }
//                    }
//                }
//            case .failure(let error):
//                // TODO: LogOut
//                print(error)
//            }
//        }
    }
}
