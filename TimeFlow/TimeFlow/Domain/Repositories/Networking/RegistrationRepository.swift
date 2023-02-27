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
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
    func registerTeacher(
        teacherRegistrationRequest: TeacherRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
    func registerExternalUser(
        externalUserRegistrationRequest: ExternalUserRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
}
