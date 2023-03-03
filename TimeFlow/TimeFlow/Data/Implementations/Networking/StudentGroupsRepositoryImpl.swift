//
//  StudentGroupsRepositoryImpl.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Alamofire
import Foundation

class StudentGroupsRepositoryImpl: StudentGroupsRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getStudentGroups(completion: ((Result<[StudentGroup], Error>) -> Void)?) {
        AF.request(
            Self.url + "group",
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetworkingConstants.headers
        ) { $0.timeoutInterval = NetworkingConstants.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
}
