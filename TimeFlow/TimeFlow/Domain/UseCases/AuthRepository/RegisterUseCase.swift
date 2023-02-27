//
//  RegisterUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 26.02.2023.
//

import Foundation
import NeedleFoundation

protocol RegisterUseCaseDependency: Dependency {
    var registerUseCaseProvider: RegisterUseCase { get }
}

class RegisterUseCase {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func executeStudent(
        request: StudentRegisterCredentials,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        authRepository.studentRegistration(studentRegisterCredentials: request, completion: completion)
    }

    func executeTeacher(
        request: TeacherRegisterCredentials,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        authRepository.teacherRegistration(teacherRegisterCredentials: request, completion: completion)
    }

    func executeExternalUser(
        request: ExternalUserCredentials,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        authRepository.externalUserRegistration(
            externalUserRegisterCredentials: request,
            completion: completion
        )
    }
}
