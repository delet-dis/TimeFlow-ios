//
//  HomeViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Combine
import ElegantCalendar
import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var calendarManager = MonthlyCalendarManager(configuration: CalendarConfiguration(
        startDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36))),
        endDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
    ))

    @Published private(set) var displayingWeeksData = DisplayingWeeksData()
    @Published var displayingWeekEnum = DisplayingWeekEnum.center

    @Published private(set) var isAbleToChangePage = true

    func displayingWeekChanged() {
        isAbleToChangePage = false

        switch displayingWeekEnum {
        case .left:
            displayingWeeksData.centerDisplayingWeek = displayingWeeksData.leftDisplayingWeek
        case .center:
            ()
        case .right:
            displayingWeeksData.centerDisplayingWeek = displayingWeeksData.rightDisplayingWeek
        }

        displayingWeeksData.leftDisplayingWeek = displayingWeeksData.centerDisplayingWeek.previousWeek
        displayingWeeksData.rightDisplayingWeek = displayingWeeksData.centerDisplayingWeek.nextWeek

        displayingWeekEnum = .center

        isAbleToChangePage = true
    }
}
