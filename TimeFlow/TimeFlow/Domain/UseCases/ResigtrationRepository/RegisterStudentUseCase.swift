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
