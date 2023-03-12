//
//  ProfileRepository.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

protocol ProfileRepository {
    func getExternalUserInfo(
        token: String,
        completion: ((Result<User, Error>) -> Void)?
    )

    func getStudentInfo(
        token: String,
        completion: ((Result<StudentUser, Error>) -> Void)?
    )

    func getEmployeeInfo(
        token: String,
        completion: ((Result<EmployeeUser, Error>) -> Void)?
    )

    func getRole(
        token: String,
        completion: ((Result<String, Error>) -> Void)?
    )

    func changePassword(
        token: String,
        password: String,
        completion: ((Result<User, Error>) -> Void)?
    )

    func changeEmail(
        token: String,
        email: String,
        completion: ((Result<User, Error>) -> Void)?
    )

    func getTeachersList(completion: ((Result<[TeachersList], Error>) -> Void)?)

    func getClassroomList(completion: ((Result<[ClassroomList], Error>) -> Void)?)
}
