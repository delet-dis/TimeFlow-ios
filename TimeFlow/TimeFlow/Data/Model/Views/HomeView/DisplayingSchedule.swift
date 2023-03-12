//
//  DisplayingSchedule.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import SwiftyUserDefaults

struct DisplayingSchedule: Codable, DefaultsSerializable {
    let type: DisplayingScheduleType
    let id: String
}
