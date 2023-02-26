//
//  TeacherCredentials.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation

struct TeacherCredentials: Encodable {
    let email: String
    let name: String
    let surname: String
    let patronymic: String
    let sex: Int
    let password: String
    let contractNumber: String
}
