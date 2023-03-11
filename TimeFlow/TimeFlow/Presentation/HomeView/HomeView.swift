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
        NavigationView {
            VStack {
                NavigationLink {
                    viewModel.profileComponent.profileView
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                .padding()

                ScheduleView(viewModel: viewModel.scheduleViewModel)
            }
            .overlay {
                LessonView(displayingLesson: nil)
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
