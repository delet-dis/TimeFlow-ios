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
        VStack {
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
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay {
                if !viewModel.isAbleToChangePage {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.00001))
                }
            }
            .overlay {
                HStack(spacing: 31) {
                    ForEach(
                        viewModel.getWeekdaySymbols(),
                        id: \.self
                    ) { weekday in
                        Text(weekday)
                            .font(
                                Font(
                                    R.font.ralewayBold(size: 15) ??
                                        .systemFont(ofSize: 15, weight: .bold)
                                )
                            )
                            .foregroundColor(viewModel.isWeekdayIsCurrentDay(weekday) ?
                                Color(uiColor: R.color.lightenRed() ?? .red) :
                                Color(uiColor: R.color.lightenBlack() ?? .black)
                            )
                    }
                }
                .padding(.bottom, 75)
            }
            .overlay {
                HStack {
                    Button {
                        withAnimation {
                            viewModel.displayingWeekEnum = .left
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .scaleEffect(1.3)
                            .bold()
                    }
                    .tint(Color(uiColor: R.color.lightenBlack() ?? .black))

                    Spacer()

                    Button {
                        withAnimation {
                            viewModel.displayingWeekEnum = .right
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .scaleEffect(1.3)
                            .bold()
                    }
                    .tint(Color(uiColor: R.color.lightenBlack() ?? .black))
                }
                .contentShape(Rectangle())
                .padding(.horizontal, -12)
            }
            .padding(.horizontal, 10)

            Spacer()
        }
        .frame(height: 130)
    }
}

struct WeekSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        WeekSwitcherView(viewModel: .init())
    }
}
