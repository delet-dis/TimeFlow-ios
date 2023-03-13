//
//  TeachersList.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation

struct TeachersList: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let surname: String
    let patronymic: String
}
