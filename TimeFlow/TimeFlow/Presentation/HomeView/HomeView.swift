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
                HStack {
                    Text("SomeText")
                        .font(
                            Font(
                                R.font.ralewayMedium(size: 16) ??
                                    .systemFont(ofSize: 20, weight: .medium)
                            )
                        )
                        .padding(.horizontal, 30)
                    if let profileView = viewModel.profileComponent?.profileView {
                        NavigationLink {
                            profileView
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding()
                    }
                }

                Group {
                    if let scheduleViewModel = viewModel.scheduleViewModel {
                        ScheduleView(viewModel: scheduleViewModel)
                    } else {
                        Spacer()
                    }
                }
                .opacity(isScheduleDisplaying ? 1 : 0)
                .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                viewModel.viewDidAppear()
            }
            .background(Color(uiColor: R.color.nearbyWhite() ?? .white))
            .onReceive(viewModel.$isScheduleDisplaying) { value in
                withAnimation {
                    isScheduleDisplaying = value
                }
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
