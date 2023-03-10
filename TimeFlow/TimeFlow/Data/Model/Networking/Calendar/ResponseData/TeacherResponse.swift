//
//  TeacherResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct TeacherResponse: Codable {
    let teacher: [Teacher]
    let lessons: [SubjectInfo]
}
