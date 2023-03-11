//
//  RefreshTokenResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expirationDate: String
}
