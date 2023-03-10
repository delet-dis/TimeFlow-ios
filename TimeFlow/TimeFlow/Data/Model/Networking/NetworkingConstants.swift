//
//  NetworkingConstants.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation
import Alamofire

class NetworkingConstants {
    static let baseUrl = "http://94.103.87.164:8081/api/v1/"
    static let signIn = "sign-in"
    static let signUpSegment = "sign-up"
    static let student = "student"
    static let employee = "employee"
    static let user = "user"
    static let groups = "groups"
    static let accountSegment = "account"
    static let role = "role"
    static let password = "password"
    static let email = "email"
    static let signOut = "sign-out"
    static let refreshToken = "refresh-tokens"

    static let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "accept": "*/*"
    ]

    static let unauthorizedStatusCode = 401
    static let wrongDataStatusCode = 401
    static let userAlreadyExistsStatusCode = 400
    static let successStatusCode = 200

    static let timeout = TimeInterval(10)
}
