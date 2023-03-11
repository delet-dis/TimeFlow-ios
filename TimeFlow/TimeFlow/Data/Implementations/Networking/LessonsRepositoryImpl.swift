//
//  CalendarRepositoryImpl.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 11.03.2023.
//

import Alamofire
import Foundation

class LessonsRepositoryImpl: LessonsRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getTeacherLessons(
        teacherId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<TeacherResponse, Error>) -> Void)?
    ) {
        let parametrs: Parameters = [
            "startDate": startDate,
            "endDate": endDate
        ]

        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.teacher)" +
                "/\(teacherId)",
            method: .get,
            parameters: parametrs,
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

    func getStudentGroupLessons(
        groupId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<GroupResponse, Error>) -> Void)?
    ) {
        let parametrs: Parameters = [
            "startDate": startDate,
            "endDate": endDate
        ]

        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.group)" +
                "/\(groupId)",
            method: .get,
            parameters: parametrs,
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

    func getClassroomLessons(
        classroomId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<ClassroomResponse, Error>) -> Void)?
    ) {
        let parametrs: Parameters = [
            "startDate": startDate,
            "endDate": endDate
        ]

        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.classroom)" +
                "/\(classroomId)",
            method: .get,
            parameters: parametrs,
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
