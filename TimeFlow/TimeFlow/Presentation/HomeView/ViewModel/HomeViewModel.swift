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

    let profileComponent: ProfileComponent

    init(profileComponent: ProfileComponent) {
        self.profileComponent = profileComponent
    }
}
