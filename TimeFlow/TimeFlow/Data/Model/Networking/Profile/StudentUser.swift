//
//  StudentUser.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

struct StudentUser: Codable {
    let userInfo: ExternalUser
    let studentNumber: String
    let group: StudentGroup
}
