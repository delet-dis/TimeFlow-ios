//
//  StudentRegistrationRequest.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation

struct StudentRegistrationRequest: Codable, RegistrationData {
    var email: String
    var name: String
    var surname: String
    var patronymic: String
    var password: String
    var sex: String
    let groupId: String
}
