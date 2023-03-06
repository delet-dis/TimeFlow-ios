//
//  NetworkHelper.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

import Alamofire
import Foundation

class NetworkingHelper {
    static func getHeadersWithBearer(token: String) -> HTTPHeaders {
        var headers: HTTPHeaders = NetworkingConstants.headers
        headers.add(.authorization(bearerToken: token))

        return headers
    }
}
