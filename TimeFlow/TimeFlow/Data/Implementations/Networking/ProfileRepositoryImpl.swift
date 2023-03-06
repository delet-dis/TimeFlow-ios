//
//  ProfileRepositoryImpl.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Alamofire
import Foundation

class ProfileRepositoryImpl: ProfileRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private static let accountSegment = "account"
    private static let studentAccountSegment = "\(accountSegment)/student"
    private static let employeeAccountSegment = "\(accountSegment)/employee"
    private static let externalUserAccountSegment = "\(accountSegment)/user"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getExternalUserInfo(token: String,
                    completion: ((Result<ExternalUser, Error>) -> Void)?) {
        AF.request(
            Self.url + Self.externalUserAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getStudentInfo(token: String,
                        completion: ((Result<StudentUser, Error>) -> Void)?) {
        AF.request(
            Self.url + Self.studentAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getEmployeeInfo(token: String,
                         completion: ((Result<EmployeeUser, Error>) -> Void)?) {
        AF.request(
            Self.url + Self.employeeAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getRole(token: String, completion: ((Result<Role, Error>) -> Void)?) {
        AF.request(
            Self.url + Self.accountSegment + "role",
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func changePassword(token: String, password: String,
                        completion: ((Result<ExternalUser, Error>) -> Void)?) {
        do {
            let encodedParam = try jsonEncoder.encode(password)
            let parameters = try JSONSerialization.jsonObject(
                with: encodedParam, options: .allowFragments
            ) as? [String: Any]
            AF.request(
                Self.url + Self.accountSegment + "password",
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: NetworkingHelper.getHeadersWithBearer(token: token)
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func changeEmail(token: String, email: String,
                     completion: ((Result<ExternalUser, Error>) -> Void)?) {
        do {
            let encodedParam = try jsonEncoder.encode(email)
            let parameters = try JSONSerialization.jsonObject(
                with: encodedParam, options: .allowFragments
            ) as? [String: Any]
            AF.request(
                Self.url + Self.accountSegment + "email",
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: NetworkingHelper.getHeadersWithBearer(token: token)
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }
}
