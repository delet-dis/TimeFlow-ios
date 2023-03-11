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
    private static let url = NetworkingConstants.baseUrl

    private static let signIn = "/\(NetworkingConstants.signIn)"
    private static let signOut = "/\(NetworkingConstants.signOut)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func login(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(authorizationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingConstants.signIn,
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
        token: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    ) {
        AF.request(
            Self.url + Self.signOut,
            method: .post,
            encoding: JSONEncoding.default,
            headers: NetworkingHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingConstants.timeout }

        completion?(.success(VoidResponse()))
    }

    func refreshToken(
        refreshTokenRequest: RefreshTokenRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(refreshTokenRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingConstants.refreshToken,
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
