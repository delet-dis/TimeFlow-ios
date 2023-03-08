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

    var body: some View {
        VStack {
            Spacer()

            WeekSwitcherView(viewModel: viewModel.weekSwitcherViewModel)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color(uiColor: R.color.mainBackgroundColor() ?? .white))
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
