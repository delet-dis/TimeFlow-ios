//
//  DateExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 07.03.2023.
//

import Foundation

extension Date {
    var previousWeek: Date {
        Calendar.autoupdatingCurrent.date(byAdding: DateComponents(day: -7), to: self)!
    }

    var nextWeek: Date {
        Calendar.autoupdatingCurrent.date(byAdding: DateComponents(day: +7), to: self)!
    }
    
    var previousDay: Date {
        return Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: self)!
    }

    var nextDay: Date {
        return Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: self)!
    }

    var startOfWeek: Date? {
        let calendar = Calendar.autoupdatingCurrent
        guard let startOfWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        ) else { return nil }
        return calendar.date(byAdding: .day, value: 1, to: startOfWeek)
    }

    var endOfWeek: Date? {
        let calendar = Calendar.autoupdatingCurrent
        guard let startOfWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        ) else { return nil }
        return calendar.date(byAdding: .day, value: 7, to: startOfWeek)
    }
}
