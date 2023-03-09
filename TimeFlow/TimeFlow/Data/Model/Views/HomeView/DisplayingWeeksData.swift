//
//  DisplayingWeeksData.swift
//  TimeFlow
//
//  Created by Igor Efimov on 07.03.2023.
//

import Foundation

struct DisplayingWeeksData {
    var leftDisplayingWeek = Date.now.previousWeek
    var centerDisplayingWeek = Date.now
    var rightDisplayingWeek = Date.now.nextWeek
}
