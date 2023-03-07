//
//  DateExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 07.03.2023.
//

import Foundation

extension Date {
    var previousWeek: Date {
        Calendar.current.date(byAdding: DateComponents(day: -7), to: self)!
    }

    var nextWeek: Date {
        Calendar.current.date(byAdding: DateComponents(day: +7), to: self)!
    }
}
