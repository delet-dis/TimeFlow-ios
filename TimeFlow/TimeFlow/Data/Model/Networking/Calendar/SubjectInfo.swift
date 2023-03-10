//
//  SubjectInfo.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct SubjectInfo: Codable {
    let id: String
    let studentGroup: [StudentGroup]
    let subject: [Subject]
    let teacher: [Teacher]
    let classroom: [Classroom]
    let timeslot: [TimeSlot]
    let data: String
    let lessonType: String
}
