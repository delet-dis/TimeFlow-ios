// Kevin Li - 11:30 PM - 6/6/20

import SwiftUI

struct DayView: View, MonthlyCalendarManagerDirectAccess {
    @Environment(\.calendarTheme) var theme: CalendarTheme

    @ObservedObject var calendarManager: MonthlyCalendarManager

    let week: Date
    let day: Date

    private let isDisplayingMonthsDifferences: Bool
    private let isDragRecentlyHappend: Bool
    private let isTapHappend: Bool

    init(
        calendarManager: MonthlyCalendarManager,
        week: Date,
        day: Date,
        isDisplayingMonthsDifferences: Bool = true,
        isDragRecentlyHappend: Bool = false,
        isTapHappend: Bool = false
    ) {
        self.calendarManager = calendarManager
        self.week = week
        self.day = day
        self.isDisplayingMonthsDifferences = isDisplayingMonthsDifferences
        self.isDragRecentlyHappend = isDragRecentlyHappend
        self.isTapHappend = isTapHappend
    }

    private var isDayWithinDateRange: Bool {
        day >= calendar.startOfDay(for: startDate) && day <= endDate
    }

    private var isDayWithinWeekMonthAndYear: Bool {
        calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
    }

    private var canSelectDay: Bool {
        datasource?.calendar(canSelectDate: day) ?? true
    }

    private var isDaySelectableAndInRange: Bool {
        isDayWithinDateRange && isDayWithinWeekMonthAndYear && canSelectDay
    }

    private var isDayToday: Bool {
        calendar.isDateInToday(day)
    }

    private var isSelected: Bool {
        guard let selectedDate = selectedDate else { return false }
        return calendar.isDate(selectedDate, equalTo: isTapHappend ? day.nextDay : day, toGranularities: [.day, .month, .year])
    }

    @State private var isUnselectAniamtionDisplaying = false

    var body: some View {
        Text(numericDay)
            .font(.custom("Raleway-Bold", size: 18))
            .foregroundColor(foregroundColor)
            .frame(width: CalendarConstants.Monthly.dayWidth, height: CalendarConstants.Monthly.dayWidth)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .opacity(opacity)
            .background(isSelected ?
                DaySelectionView(isDragRecentyHappend: isDragRecentlyHappend).erased :
                            DayUnselectionView()
                .opacity(isUnselectAniamtionDisplaying ? 1 : 0)
                .erased
            )
            .onTapGesture(perform: notifyManager)
            .onChange(of: isSelected) { newValue in
                if !newValue {
                    isUnselectAniamtionDisplaying = true

                    withAnimation(.easeIn(duration: 0.7)) {
                        isUnselectAniamtionDisplaying = false
                    }
                }
            }
    }

    private var numericDay: String {
        String(calendar.component(.day, from: day))
    }

    private var foregroundColor: Color {
        if isDayToday {
            return Color("LightenRed")
        } else {
            return Color("Gray")
        }
    }

    private var backgroundColor: some View {
        Group {
            if isDayToday {
                theme.todayBackgroundColor
            } else if isDaySelectableAndInRange || !isDisplayingMonthsDifferences {
                theme.primary
                    .opacity(datasource?.calendar(backgroundColorOpacityForDate: day) ?? 1)
            } else {
                Color.clear
            }
        }
    }

    private var opacity: Double {
        if isDisplayingMonthsDifferences {
            guard !isDayToday else { return 1 }
            return isDaySelectableAndInRange ? 1 : 0.15
        } else {
            return 1
        }
    }

    private func notifyManager() {
        guard isDayWithinDateRange && canSelectDay else { return }

        if isDayToday || isDayWithinWeekMonthAndYear || !isDisplayingMonthsDifferences {
            calendarManager.dayTapped(day: day.nextDay, withHaptic: true)
        }
    }
}

private struct DayUnselectionView: View {
    @State private var startBounce = false

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(
                Material.thin
            )
            .shadow(color: .black.opacity(0.3), radius: 6.8, x: 0, y: 10)
            .frame(width: radius, height: radius)
            .opacity(startBounce ? 1 : 0)
            .animation(.interpolatingSpring(stiffness: 150, damping: 10))
            .onAppear(perform: startBounceAnimation)
    }

    private var radius: CGFloat {
        startBounce ? CalendarConstants.Monthly.dayWidth + 15 : CalendarConstants.Monthly.dayWidth + 6
    }

    private func startBounceAnimation() {
        startBounce = true
    }
}

private struct DaySelectionView: View {
    @State private var startBounce = false

    var isDragRecentyHappend = false

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(
                Material.thin
            )
            .shadow(color: .black.opacity(0.3), radius: 6.8, x: 0, y: 10)
            .frame(width: radius, height: radius)
            .opacity(startBounce ? 1 : 0)
            .if(!isDragRecentyHappend) { view in
                view.animation(.interpolatingSpring(stiffness: 150, damping: 10))
            }
            .onAppear(perform: startBounceAnimation)
    }

    private var radius: CGFloat {
        startBounce ? CalendarConstants.Monthly.dayWidth + 6 : CalendarConstants.Monthly.dayWidth + 25
    }

    private func startBounceAnimation() {
        startBounce = true
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        LightDarkThemePreview {
            DayView(calendarManager: .mock, week: Date(), day: Date())

            DayView(calendarManager: .mock, week: Date(), day: .daysFromToday(3))
        }
    }
}
