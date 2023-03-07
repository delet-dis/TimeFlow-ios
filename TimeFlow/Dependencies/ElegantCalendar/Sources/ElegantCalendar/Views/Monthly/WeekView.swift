// Kevin Li - 10:54 PM - 6/6/20

import SwiftUI

public struct WeekView: View, MonthlyCalendarManagerDirectAccess {

    let calendarManager: MonthlyCalendarManager

    let week: Date

    public init(calendarManager: MonthlyCalendarManager, week: Date) {
        self.calendarManager = calendarManager
        self.week = week
    }

    private var days: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week) else {
            return []
        }
        return calendar.generateDates(
            inside: weekInterval,
            matching: .everyDay)
    }

    public var body: some View {
        HStack(spacing: CalendarConstants.Monthly.gridSpacing) {
            ForEach(days, id: \.self) { day in
                DayView(calendarManager: self.calendarManager, week: self.week, day: day)
            }
        }
    }

}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        LightDarkThemePreview {
            WeekView(calendarManager: .mock, week: Date())

            WeekView(calendarManager: .mock, week: .daysFromToday(-7))
        }
    }
}
