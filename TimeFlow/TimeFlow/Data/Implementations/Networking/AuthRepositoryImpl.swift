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

    func login(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<Bool, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(authorizationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url,
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

    func logout(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    ) {
        // TODO: Add logout
//        AF.request(
//            Self.url + "logout",
//            method: .post,
//            encoding: JSONEncoding.default,
//            headers: NetworkingHelper.getHeadersWithAuth(userCredentials)
//        ) { $0.timeoutInterval = NetworkingConstants.timeout }
//            .validate()
//            .response { [self] result in
//                result.processResult(jsonDecoder: jsonDecoder, completion: completion)
//            }
    }
}
