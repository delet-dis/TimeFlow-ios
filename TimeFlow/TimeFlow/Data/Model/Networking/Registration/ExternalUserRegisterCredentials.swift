//
//  ExternalUserRegisterCredentials.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation

struct ExternalUserCredentials: Encodable {
    let email: String
    let name: String
    let surname: String
    let patronymic: String
    let password: String
    let sex: GenderPickerEnum
}
