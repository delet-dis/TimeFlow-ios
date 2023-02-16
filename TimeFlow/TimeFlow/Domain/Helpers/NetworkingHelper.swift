//
//  NetworkingHelper.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Alamofire
import Foundation

class NetworkingHelper {
    static func getHeadersWithAuth(_ userCredentials: UserCredentials) -> HTTPHeaders {
        var headers: HTTPHeaders = NetworkingConstants.headers
        headers.add(.authorization(username: userCredentials.email, password: userCredentials.password))

        return headers
    }
}
