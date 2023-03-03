//
//  RegisterExternalUserUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Foundation
import NeedleFoundation

protocol RegisterExternalUserUseCaseDependency: Dependency {
    var registerExternalUserUseCaseProvider: RegisterExternalUserUseCase { get }
}

class RegisterExternalUserUseCase {
    private let registrationRepository: RegistrationRepository
    private let saveTokensUseCase: SaveTokensUseCase
    private let saveAuthStatusUseCase: SaveAuthStatusUseCase

    init(
        registrationRepository: RegistrationRepository,
        saveTokensUseCase: SaveTokensUseCase,
        saveAuthStatusUseCase: SaveAuthStatusUseCase
    ) {
        self.registrationRepository = registrationRepository
        self.saveTokensUseCase = saveTokensUseCase
        self.saveAuthStatusUseCase = saveAuthStatusUseCase
    }

    func execute(
        externalUserRegistrationRequest: ExternalUserRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerExternalUser(
            externalUserRegistrationRequest: externalUserRegistrationRequest,
            completion: { [weak self] result in
                completion?(result)

                if case .success(let loginResponse) = result {
                    self?.saveTokensUseCase.execute(
                        authToken: loginResponse.accessToken,
                        refreshToken: loginResponse.refreshToken ?? "",
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
