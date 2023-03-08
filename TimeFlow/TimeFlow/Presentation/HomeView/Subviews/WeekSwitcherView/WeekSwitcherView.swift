//
//  WeekSwitcherView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 08.03.2023.
//

import ElegantCalendar
import SwiftUI

struct WeekSwitcherView: View {
    @ObservedObject var viewModel: WeekSwitcherViewModel

    var body: some View {
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
                    week: viewModel.displayingWeeksData.leftDisplayingWeek,
                    isDisplayingMonthsDifferences: false,
                    isDragReccentlyHappend: viewModel.isDragRecentlyHappend
                )
                .tag(DisplayingWeekEnum.left)
                .onDisappear {
                    viewModel.displayingWeekChanged()
                }

                WeekView(
                    calendarManager: viewModel.calendarManager,
                    week: viewModel.displayingWeeksData.centerDisplayingWeek,
                    isDisplayingMonthsDifferences: false,
                    isDragReccentlyHappend: viewModel.isDragRecentlyHappend
                )
                .tag(DisplayingWeekEnum.center)
                .onDisappear {
                    viewModel.displayingWeekChanged()
                }

                WeekView(
                    calendarManager: viewModel.calendarManager,
                    week: viewModel.displayingWeeksData.rightDisplayingWeek,
                    isDisplayingMonthsDifferences: false,
                    isDragReccentlyHappend: viewModel.isDragRecentlyHappend
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
                                gradient: Gradient(colors: [
                                    .init(uiColor: R.color.mainBackgroundColor() ?? .white),
                                    .clear
                                ]),
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
                                gradient: Gradient(colors: [
                                    .clear,
                                    .init(uiColor: R.color.mainBackgroundColor() ?? .white)
                                ]),
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
    }
}

struct WeekSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        WeekSwitcherView(viewModel: .init())
    }
}
