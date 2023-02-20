//
//  AuthRepositoryImpl.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Alamofire
import Foundation

class AuthRepositoryImpl: AuthRepository {
    // TODO: Add auth URL
    private static let url = "\(NetworkingConstants.baseUrl)"
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }
    
    func login(userCredentials: UserCredentials, completion: ((Result<Bool, Error>) -> Void)?) {
        AF.request(
            Self.url + "login",
            method: .post,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithAuth(userCredentials)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
            }
    }
    
    func logout(userCredentials: UserCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        AF.request(
            Self.url + "logout",
            method: .post,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithAuth(userCredentials)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
            }
    }

    func studentRegistration(studentRegisterCredentials: StudentRegisterCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(studentRegisterCredentials)
            let parametrs = try JSONSerialization.jsonObject(with: encodedParametrs, options: .allowFragments) as? [String: Any]
            AF.request(
                Self.url + "student/sign-up",
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) {
                $0.timeoutInterval = NetworkingConstants.timeout
            }
            .validate()
            .response { [self] result in
                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
            }
        }
        catch {
            completion?(.failure(error))
        }
    }
    
    func teacherRegistration(teacherRegisterCredentials: TeacherCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(teacherRegisterCredentials)
            let parametrs = try JSONSerialization.jsonObject(with: encodedParametrs, options: .allowFragments) as? [String: Any]
            AF.request(
                Self.url + "employee/sign-up",
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) {
                $0.timeoutInterval = NetworkingConstants.timeout
            }
            .validate()
            .response { [self] result in
                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
            }
        }
        catch {
            completion?(.failure(error))
        }
    }
    
    func externalUserRegistration(externalUserRegisterCredentials: ExternalUserCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(externalUserRegisterCredentials)
            let parametrs = try JSONSerialization.jsonObject(with: encodedParametrs, options: .allowFragments) as? [String: Any]
            AF.request(
                Self.url + "user/sign-up",
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingConstants.headers
            ) {
                $0.timeoutInterval = NetworkingConstants.timeout
            }
            .validate()
            .response { [self] result in
                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
            }
        }
        catch {
            completion?(.failure(error))
        }
    }
}
