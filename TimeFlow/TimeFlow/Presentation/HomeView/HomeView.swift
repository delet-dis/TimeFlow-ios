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

            HStack {
                Button {
                    withAnimation {
                        viewModel.displayingWeekEnum = .left
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .scaleEffect(1.3)
                }

                TabView(selection: $viewModel.displayingWeekEnum) {
                    WeekView(
                        calendarManager: viewModel.calendarManager,
                        week: viewModel.displayingWeeksData.leftDisplayingWeek
                    )
                    .tag(DisplayingWeekEnum.left)
                    .onDisappear {
                        viewModel.displayingWeekChanged()
                    }

                    WeekView(
                        calendarManager: viewModel.calendarManager,
                        week: viewModel.displayingWeeksData.centerDisplayingWeek
                    )
                    .tag(DisplayingWeekEnum.center)
                    .onDisappear {
                        viewModel.displayingWeekChanged()
                    }

                    WeekView(
                        calendarManager: viewModel.calendarManager,
                        week: viewModel.displayingWeeksData.rightDisplayingWeek
                    )
                    .tag(DisplayingWeekEnum.right)
                    .onDisappear {
                        viewModel.displayingWeekChanged()
                    }
                }
                .frame(height: 50)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .overlay {
                    if !viewModel.isAbleToChangePage {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.00001))
                    }
                }
                .overlay {
                    HStack {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white, Color.clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 6)
                            .allowsHitTesting(false)

                        Spacer()

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.white]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 6)
                            .allowsHitTesting(false)
                    }
                }

                Button {
                    withAnimation {
                        viewModel.displayingWeekEnum = .right
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .scaleEffect(1.3)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct HomeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        HomeView(viewModel: mainComponent.homeComponent.homeViewModel)
    }
}
