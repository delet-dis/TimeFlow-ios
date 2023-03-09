//
//  ScheduleView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 09.03.2023.
//

import ElegantCalendar
import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel

    var body: some View {
        VStack {
            Spacer()

            WeekSwitcherView(viewModel: viewModel.weekSwitcherViewModel)

            Spacer()
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: .init())
    }
}
