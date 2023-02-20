//
//  AuthRepository.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

protocol AuthRepository {
    func login(userCredentials: UserCredentials, completion: ((Result<Bool, Error>) -> Void)?)
    func logout(userCredentials: UserCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?)
    func studentRegistration(studentRegisterCredentials: StudentRegisterCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?)
    func teacherRegistration(teacherRegisterCredentials: TeacherCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?)
    func externalUserRegistration(externalUserRegisterCredentials: ExternalUserCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?)
}
