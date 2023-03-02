//
//  RegisterStudentUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Foundation
import NeedleFoundation

protocol RegisterStudentUseCaseDependency: Dependency {
    var registerStudentUseCaseProvider: RegisterStudentUseCase { get }
}

class RegisterStudentUseCase {
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
        studentRegistrationRequest: StudentRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerStudent(
            studentRegistrationRequest: studentRegistrationRequest,
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
