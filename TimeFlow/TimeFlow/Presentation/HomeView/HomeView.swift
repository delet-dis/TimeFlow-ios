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
    private static let mainComponent = MainComponent()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ProfileView(viewModel: HomeView.mainComponent.profileComponent.profileViewModel), label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                })
                .padding()

                ScheduleView(viewModel: viewModel.scheduleViewModel)
            }
            .padding(.horizontal, 24)
            .background(Color(uiColor: R.color.nearbyWhite() ?? .white))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
