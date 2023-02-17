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

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute(userCredentials: UserCredentials, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        authRepository.login(userCredentials: userCredentials, completion: completion)
    }
}
