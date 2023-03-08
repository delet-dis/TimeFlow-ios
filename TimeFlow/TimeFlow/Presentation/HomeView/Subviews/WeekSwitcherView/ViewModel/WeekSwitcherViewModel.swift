//
//  WeekSwitcherViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 08.03.2023.
//

import Combine
import ElegantCalendar
import Foundation

class WeekSwitcherViewModel: ObservableObject {
    @Published private(set) var calendarManager = MonthlyCalendarManager(configuration: CalendarConfiguration(
        startDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36))),
        endDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
    ))

    @Published private(set) var displayingWeeksData = DisplayingWeeksData()
    @Published var displayingWeekEnum = DisplayingWeekEnum.center

    @Published private(set) var isAbleToChangePage = true

    @Published var isDragRecentlyHappend = false

    private var dayPickedClosure: ((Date) -> Void)? = nil

    private var subscribers: Set<AnyCancellable> = []

    init() {
        initDisplayingWeekObserving()
    }

    func setDayPickedClosure(_ closure: @escaping ((Date) -> Void)) {
        dayPickedClosure = closure
    }

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

    private func initDisplayingWeekObserving() {
        $displayingWeekEnum.sink { [weak self] _ in
            self?.isDragRecentlyHappend = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.isDragRecentlyHappend = false
            }
        }
        .store(in: &subscribers)
    }
}
