//
//  RefreshTokensUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 11.03.2023.
//

import Foundation
import NeedleFoundation

protocol RefreshTokenUseCaseDependency: Dependency {
    var refreshTokenUseCaseProvider: RefreshTokenUseCase { get }
}

class RefreshTokenUseCase {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute(
        refreshTokenRequest: RefreshTokenRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    ) {
        authRepository.refreshToken(refreshTokenRequest: refreshTokenRequest, completion: completion)
    }
}
