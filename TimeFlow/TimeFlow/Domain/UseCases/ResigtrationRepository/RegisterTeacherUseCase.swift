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

    init(registrationRepository: RegistrationRepository) {
        self.registrationRepository = registrationRepository
    }

    func execute(
        teacherRegistrationRequest: TeacherRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        registrationRepository.registerTeacher(
            teacherRegistrationRequest: teacherRegistrationRequest,
            completion: completion
        )
    }
}
