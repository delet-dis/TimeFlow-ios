//
//  ExternalUserRegistrationRequest.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation

struct ExternalUserRegistrationRequest: Codable, RegistrationData {
    var email: String
    var name: String
    var surname: String
    var patronymic: String
    var password: String
    var sex: Int
}
