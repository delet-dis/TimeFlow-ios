//
//  RefreshTokenImpl.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Alamofire
import Foundation

class RefreshTokenRepositoryImpl: RefreshTokenRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func changeValueByKey(
        _ key: String,
        completion: ((Result<RefreshTokenResponse, Error>) -> Void)?
    ) {
        do {
            let encodedParametrs = try jsonEncoder.encode(key)
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
