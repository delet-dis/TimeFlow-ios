//
//  HomeView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import ElegantCalendar
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @ObservedObject var calendarManager = ElegantCalendarManager(
        configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36))),
                                             endDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))))

    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
