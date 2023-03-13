//
//  StudentUser.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

struct StudentUser: Codable {
    let userInfo: User
    let studentNumber: String
    let group: StudentGroup
}
