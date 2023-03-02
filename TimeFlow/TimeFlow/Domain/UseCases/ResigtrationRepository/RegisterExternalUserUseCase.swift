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

    init(
        registrationRepository: RegistrationRepository,
        saveTokensUseCase: SaveTokensUseCase
    ) {
        self.registrationRepository = registrationRepository
        self.saveTokensUseCase = saveTokensUseCase
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
                        refreshToken: loginResponse.refreshToken ?? ""
                    )
                }
            }
        )
    }
}
