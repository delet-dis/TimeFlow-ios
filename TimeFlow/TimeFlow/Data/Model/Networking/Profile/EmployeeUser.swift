//
//  EmployeeUser.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

struct EmployeeUser: Codable {
    let userInfo: ExternalUser
    let contractNumber: String
    let posts: [PostData]
}
