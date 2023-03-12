//
//  ScheduleView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 09.03.2023.
//

import SPAlert
import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel

    @State private var isTasksListDisplaying = true

    var body: some View {
        VStack {
            Spacer()

            WeekSwitcherView(viewModel: viewModel.weekSwitcherViewModel)

            TabView(selection: $viewModel.displayingDayEnum) {
                LessonsListView(dispalyingLessons: viewModel.displayingDaysData.leftDisplayingDayData)
                    .tag(DisplayingDayEnum.left)
                    .onDisappear {
                        viewModel.displayingDayChanged()
                    }

                LessonsListView(dispalyingLessons: viewModel.displayingDaysData.centerDisplayingDayData)
                    .tag(DisplayingDayEnum.center)
                    .onDisappear {
                        viewModel.displayingDayChanged()
                    }

                LessonsListView(dispalyingLessons: viewModel.displayingDaysData.rightDisplayingDayData)
                    .tag(DisplayingDayEnum.right)
                    .onDisappear {
                        viewModel.displayingDayChanged()
                    }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay {
                if !viewModel.isAbleToChangePage {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.00001))
                }
            }
            .opacity(isTasksListDisplaying ? 1 : 0.0001)
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
        .onReceive(viewModel.$isLessonsListDisplaying) { value in
            withAnimation {
                isTasksListDisplaying = value
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
