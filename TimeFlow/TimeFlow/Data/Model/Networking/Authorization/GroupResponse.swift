//
//  GroupResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation

struct GroupResponse: Codable {
    let groups: [StudentsGroup]?
}

struct StudentsGroup: Codable, Equatable {
    let id: String
    let number: Int
}
