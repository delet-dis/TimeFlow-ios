//
//  RegistrationRepository.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Foundation

protocol RegistrationRepository {
    func registerStudent(
        studentRegistrationRequest: StudentRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    )
    func registerTeacher(
        teacherRegistrationRequest: TeacherRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    )
    func registerExternalUser(
        externalUserRegistrationRequest: ExternalUserRegistrationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    )
}
