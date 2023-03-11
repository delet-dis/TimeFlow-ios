//
//  LogoutUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation
import NeedleFoundation

protocol LogoutUseCaseDependency: Dependency {
    var logoutUseCaseProvider: LogoutUseCase { get }
}

class LogoutUseCase {
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
        token: String,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        authRepository.logout(
            token: token,
            completion: nil
        )

        saveTokensUseCase.execute(authToken: "", refreshToken: "")

        saveAuthStatusUseCase.execute(isAuthorized: false)
    }
}
