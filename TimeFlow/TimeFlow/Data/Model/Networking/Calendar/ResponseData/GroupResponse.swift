//
//  GroupResponse.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct GroupResponse: Codable {
    let studentGroup: [StudentGroup]
    let lessons: [SubjectResponse]
}
