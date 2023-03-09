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
        VStack {
            NavigationView {
                NavigationLink(destination: ProfileView(viewModel: HomeView.mainComponent.profileComponent.profileViewModel), label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                })
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
