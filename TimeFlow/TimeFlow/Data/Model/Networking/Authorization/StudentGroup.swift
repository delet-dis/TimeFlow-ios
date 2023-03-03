//
//  StudentGroup.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation

struct StudentGroup: Codable, Identifiable, Hashable {
    let id: String
    let number: Int?
}
