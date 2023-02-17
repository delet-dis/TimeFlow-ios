//
//  NetworkingConstants.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation
import Alamofire

class NetworkingConstants {
    static let baseUrl = "http://94.103.87.164:1985/api/v1/"

    static let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]

    static let unauthorizedStatusCode = 401
    static let successStatusCode = 200

    static let timeout = TimeInterval(10)
}
