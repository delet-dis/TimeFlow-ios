//
//  LoginUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation
import NeedleFoundation

protocol LoginUseCaseDependency: Dependency {
    var loginUseCaseProvider: LoginUseCase { get }
}

class LoginUseCase {
    private let authRepository: AuthRepository
    private let saveTokensUseCase: SaveTokensUseCase
    private let saveAuthStatusUseCase: SaveAuthStatusUseCase

    init(
        authRepository: AuthRepository,
        saveTokensUseCase: SaveTokensUseCase,
        saveAuthStatusUseCase: SaveAuthStatusUseCase
    ) {
        self.authRepository = authRepository
        self.saveTokensUseCase = saveTokensUseCase
        self.saveAuthStatusUseCase = saveAuthStatusUseCase
    }

    func execute(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)? = nil
    ) {
        authRepository.login(
            authorizationRequest: authorizationRequest,
            completion: { [weak self] result in
                completion?(result)

                if case .success(let loginResponse) = result {
                    self?.saveTokensUseCase.execute(
                        authToken: loginResponse.accessToken,
                        refreshToken: loginResponse.refreshToken,
                        completion: { [weak self] result in
                            if case .success = result {
                                self?.saveAuthStatusUseCase.execute(isAuthorized: true)
                            }
                        }
                    )
                }
            }
        )
    }
}
