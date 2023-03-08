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
    @Published private(set) var weekSwitcherViewModel: WeekSwitcherViewModel

    init() {
        self.weekSwitcherViewModel = .init()
        self.weekSwitcherViewModel.setDayPickedClosure {[weak self] day in
            self?.changeDisplayingDay(day)
        }
    }

    private func changeDisplayingDay(_ date: Date) {
        print(date)
    }
}
