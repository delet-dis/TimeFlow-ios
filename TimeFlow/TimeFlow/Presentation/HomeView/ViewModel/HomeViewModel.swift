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
    @Published private(set) var scheduleViewModel = ScheduleViewModel()
}
