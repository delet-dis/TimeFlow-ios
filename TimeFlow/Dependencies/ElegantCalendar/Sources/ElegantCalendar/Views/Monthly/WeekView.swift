// Kevin Li - 10:54 PM - 6/6/20

import SwiftUI

public struct WeekView: View, MonthlyCalendarManagerDirectAccess {

    let calendarManager: MonthlyCalendarManager

    let week: Date

    private let isDisplayingMonthsDifferences: Bool
    private let isDragRecentlyHappend: Bool
    private let isTapHappend: Bool

    public init(
        calendarManager: MonthlyCalendarManager,
        week: Date,
        isDisplayingMonthsDifferences: Bool = true,
        isDragReccentlyHappend: Bool = false,
        isTapHappend: Bool = false
    ) {
        self.calendarManager = calendarManager
        self.week = week
        self.isDisplayingMonthsDifferences = isDisplayingMonthsDifferences
        self.isDragRecentlyHappend = isDragReccentlyHappend
        self.isTapHappend = isTapHappend
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
                DayView(
                    calendarManager: self.calendarManager,
                    week: self.week,
                    day: day,
                    isDisplayingMonthsDifferences: isDisplayingMonthsDifferences,
                    isDragRecentlyHappend: isDragRecentlyHappend,
                    isTapHappend: isTapHappend
                )
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
