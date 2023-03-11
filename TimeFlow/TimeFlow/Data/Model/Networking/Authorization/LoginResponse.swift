//
//  LoginResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expirationDate: String
}
