//
//  Timeslot.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

struct TimeSlot: Codable {
    let id: String
    let sequenceNumber: Int
    let beginTime: String
    let endTime: String
}
