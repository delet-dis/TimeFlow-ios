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

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute(
        userCredentials: UserCredentials,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        authRepository.logout(userCredentials: userCredentials, completion: completion)
    }
}
