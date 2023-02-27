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

    init(registrationRepository: RegistrationRepository) {
        self.registrationRepository = registrationRepository
    }

    func execute(
        externalUserRegistrationRequest: ExternalUserRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerExternalUser(
            externalUserRegistrationRequest: externalUserRegistrationRequest,
            completion: completion
        )
    }
}
