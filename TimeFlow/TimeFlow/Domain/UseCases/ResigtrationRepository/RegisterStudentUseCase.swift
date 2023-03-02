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

    init(
        registrationRepository: RegistrationRepository
    ) {
        self.registrationRepository = registrationRepository
    }

    func execute(
        studentRegistrationRequest: StudentRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerStudent(
            studentRegistrationRequest: studentRegistrationRequest,
            completion: completion
        )
    }
}
