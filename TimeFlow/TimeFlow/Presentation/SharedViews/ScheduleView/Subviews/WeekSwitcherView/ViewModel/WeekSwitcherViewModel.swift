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
    @Published private(set) var isTapHappend = false

    private(set) var isChangesAnimationRequired = false

    private var dayPickedClosure: ((Date) -> Void)?

    private var subscribers: Set<AnyCancellable> = []

    init() {
        initDisplayingWeekObserving()

        calendarManager.setDidSelectDayClosure { [weak self] day in
            self?.dayPickedClosure?(day)
        }

        calendarManager.selectDay(.now)
    }

    func selectDate(_ date: Date) {
        calendarManager.selectDay(date)

        if let startOfWeek = displayingWeeksData.centerDisplayingWeek.startOfWeek, date < startOfWeek {
            isChangesAnimationRequired = true
            displayingWeekEnum = .left

            DispatchQueue.runAsyncOnMainWithDelay { [weak self] in
                self?.isChangesAnimationRequired = false

                self?.displayingWeekChanged()
            }
        }

        if let endOfWeek = displayingWeeksData.centerDisplayingWeek.endOfWeek, date > endOfWeek {
            isChangesAnimationRequired = true
            displayingWeekEnum = .right

            DispatchQueue.runAsyncOnMainWithDelay { [weak self] in
                self?.isChangesAnimationRequired = false

                self?.displayingWeekChanged()
            }
        }
    }

    func toggleIsTapHappend() {
        isTapHappend = true
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

    func getWeekdaySymbols() -> [String] {
        calendarManager.configuration.calendar.shortWeekdaySymbols.shift(withDistance:
            calendarManager.configuration.calendar.firstWeekday - 1
        )
    }

    func isWeekdayIsCurrentDay(_ weekday: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"

        return weekday == formatter.string(from: .now)
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
