//
//  ScheduleViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 09.03.2023.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published private(set) var weekSwitcherViewModel: WeekSwitcherViewModel

    init() {
        self.weekSwitcherViewModel = .init()
        self.weekSwitcherViewModel.setDayPickedClosure { [weak self] day in
            self?.changeDisplayingDay(day)
        }
    }

    private func changeDisplayingDay(_ date: Date) {
        print(date)
    }
}
