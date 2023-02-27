//
//  RegistrationRepositoryImpl.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Alamofire
import Foundation

class RegistrationRepositoryImpl: RegistrationRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private static let signUpSegment = "sign-up"
    private static let studentRegistrationSegment = "student/\(signUpSegment)"
    private static let teacherRegistrationSegment = "employee/\(signUpSegment)"
    private static let externalUserRegistrationSegment = "user/\(signUpSegment)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func registerStudent(
        studentRegistrationRequest: StudentRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(studentRegistrationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + Self.studentRegistrationSegment,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder, completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func registerTeacher(
        teacherRegistrationRequest: TeacherRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(teacherRegistrationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + Self.teacherRegistrationSegment,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder, completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func registerExternalUser(
        externalUserRegistrationRequest: ExternalUserRegistrationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(externalUserRegistrationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + Self.externalUserRegistrationSegment,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder, completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }
}
