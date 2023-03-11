//
//  LessonResponse.swift
//  TimeFlow
//
//  Created by Igor Efimov on 10.03.2023.
//

import Foundation

struct LessonResponse: Codable {
    let id: String
    let studentGroup: StudentGroup
    let subject: Subject
    let teacher: Teacher
    let classroom: Classroom
    let timeslot: Timeslot
    let date: String
    let lessonType: String
}
