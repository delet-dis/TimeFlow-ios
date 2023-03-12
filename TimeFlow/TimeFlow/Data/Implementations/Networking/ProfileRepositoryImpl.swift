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

    private static let accountSegment = NetworkingConstants.accountSegment
    private static let studentAccountSegment = "\(accountSegment)/\(NetworkingConstants.student)"
    private static let employeeAccountSegment = "\(accountSegment)/\(NetworkingConstants.employee)"
    private static let externalUserAccountSegment = "\(accountSegment)/\(NetworkingConstants.user)"

    private static let role = "/\(NetworkingConstants.role)"
    private static let password = "/\(NetworkingConstants.password)"
    private static let email = "/\(NetworkingConstants.email)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    private let requestInterceptor: RequestInterceptor

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder, requestInterceptor: RequestInterceptor) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }

    func getExternalUserInfo(
        token: String,
        completion: ((Result<User, Error>) -> Void)?
    ) {
        AF.request(
            Self.url + Self.externalUserAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getStudentInfo(
        token: String,
        completion: ((Result<StudentUser, Error>) -> Void)?
    ) {
        AF.request(
            Self.url + Self.studentAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getEmployeeInfo(
        token: String,
        completion: ((Result<EmployeeUser, Error>) -> Void)?
    ) {
        AF.request(
            Self.url + Self.employeeAccountSegment,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func getRole(token: String, completion: ((Result<String, Error>) -> Void)?) {
        AF.request(
            Self.url + Self.accountSegment + Self.role,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func changePassword(
        token: String,
        password: String,
        completion: ((Result<User, Error>) -> Void)?
    ) {
        do {
            let encodedParam = try jsonEncoder.encode(password)
            let parameters = try JSONSerialization.jsonObject(
                with: encodedParam, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + Self.accountSegment + Self.password,
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: NetworkingHelper.getHeadersWithBearer(token: token),
                interceptor: requestInterceptor
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(
                        jsonDecoder: jsonDecoder,
                        completion: completion
                    )
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func changeEmail(
        token: String,
        email: String,
        completion: ((Result<User, Error>) -> Void)?
    ) {
        do {
            let encodedParam = try jsonEncoder.encode(email)
            let parameters = try JSONSerialization.jsonObject(
                with: encodedParam, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + Self.accountSegment + Self.email,
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: NetworkingHelper.getHeadersWithBearer(token: token),
                interceptor: requestInterceptor
            ) { $0.timeoutInterval = NetworkingConstants.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(
                        jsonDecoder: jsonDecoder,
                        completion: completion
                    )
                }
        } catch {
            completion?(.failure(error))
        }
    }
}
