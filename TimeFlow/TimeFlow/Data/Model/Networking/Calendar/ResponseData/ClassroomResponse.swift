//
//  ClassroomResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct ClassroomResponse: Codable {
    let classroom: [Classroom]
    let lessons: [SubjectResponse]
}
