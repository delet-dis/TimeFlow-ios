//
//  HomeView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import SPAlert
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var isScheduleDisplaying = false

    var body: some View {
        NavigationView {
            VStack {
                if let profileView = viewModel.profileComponent?.profileView {
                    NavigationLink {
                        profileView
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }

                Group {
                    if let scheduleViewModel = viewModel.scheduleViewModel {
                        ScheduleView(viewModel: scheduleViewModel)
                    }
                }
                .opacity(isScheduleDisplaying ? 1 : 0)
            }
            .overlay {
                LessonView(displayingLesson: nil)
            }
            .padding(.horizontal, 24)
            .background(Color(uiColor: R.color.nearbyWhite() ?? .white))
            .onChange(of: viewModel.isScheduleDisplaying) { newValue in
                withAnimation {
                    isScheduleDisplaying = newValue
                }
            }
            .onAppear {
                viewModel.viewDidAppear()
            }
        }
        .SPAlert(
            isPresent: $viewModel.isAlertShowing,
            message: viewModel.alertText,
            dismissOnTap: false,
            preset: .error,
            haptic: .error
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
