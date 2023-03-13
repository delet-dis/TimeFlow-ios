// Kevin Li - 1:54 PM - 6/13/20

import Foundation

extension Date {

    static func daysFromToday(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(60*60*24*days))
    }

    var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var previousDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

