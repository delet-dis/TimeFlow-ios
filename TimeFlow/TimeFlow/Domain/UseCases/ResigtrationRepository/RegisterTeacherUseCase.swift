//
//  RegisterTeacherUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Foundation
import NeedleFoundation

protocol RegisterTeacherUseCaseDependency: Dependency {
    var registerStudentUseCaseProvider: RegisterTeacherUseCase { get }
}

class RegisterTeacherUseCase {
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
        teacherRegistrationRequest: TeacherRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerTeacher(
            teacherRegistrationRequest: teacherRegistrationRequest,
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
