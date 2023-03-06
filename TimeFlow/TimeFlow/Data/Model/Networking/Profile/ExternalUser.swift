//
//  ExternalUser.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

struct ExternalUser: Codable {
    let id: String
    let email: String
    let role: String
    let name: String
    let surname: String
    let patronymic: String
    let accountStatus: String
    let sex: String
}
