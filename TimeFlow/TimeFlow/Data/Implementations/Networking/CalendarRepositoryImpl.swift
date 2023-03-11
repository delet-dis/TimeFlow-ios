//
//  CalendarRepositoryImpl.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 11.03.2023.
//

import Alamofire
import Foundation

class CalendarRepositoryImpl: CalendarRepository {
    private static let url = "\(NetworkingConstants.baseUrl)"

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getTeacherLessons(teacherId: String, startDate: String, endDate: String, completion: ((Result<TeacherResponse, Error>) -> Void)?) {
        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.teacher)" +
                "/\(teacherId)?startDate=\(startDate)&endDate=\(endDate)",
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

    func getStudentGroupLessons(groupId: String, startDate: String, endDate: String, completion: ((Result<GroupResponse, Error>) -> Void)?) {
        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.group)" +
                "/\(groupId)?startDate=\(startDate)&endDate=\(endDate)",
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

    func getClassroomLessons(classRoomId: String, startDate: String, endDate: String, completion: ((Result<ClassroomResponse, Error>) -> Void)?) {
        AF.request(
            Self.url +
                "\(NetworkingConstants.lessons)/\(NetworkingConstants.classroom)" +
                "/\(classRoomId)?startDate=\(startDate)&endDate=\(endDate)",
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
