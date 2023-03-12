//
//  ScheduleViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 09.03.2023.
//

import Combine
import Foundation

class ScheduleViewModel: ObservableObject {
    @Published private(set) var weekSwitcherViewModel: WeekSwitcherViewModel

    @Published var displayingDayEnum = DisplayingDayEnum.center
    @Published private(set) var displayingDaysData = DisplayingDaysData()

    @Published private(set) var isAbleToChangePage = true

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    private let displayingSchedule: DisplayingSchedule

    private var displayingDay = Date.now

    private var subscribers: Set<AnyCancellable> = []

    private let getTeacherLessonsUseCase: GetTeacherLessonsUseCase
    private let getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase
    private let getClassroomLessonsUseCase: GetClassroomLessonsUseCase

    init(
        displayingSchedule: DisplayingSchedule,
        getTeacherLessonsUseCase: GetTeacherLessonsUseCase,
        getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase,
        getClassroomLessonsUseCase: GetClassroomLessonsUseCase
    ) {
        self.displayingSchedule = displayingSchedule

        self.getTeacherLessonsUseCase = getTeacherLessonsUseCase
        self.getStudentGroupLessonsUseCase = getStudentGroupLessonsUseCase
        self.getClassroomLessonsUseCase = getClassroomLessonsUseCase

        self.weekSwitcherViewModel = .init()

        weekSwitcherViewModel.setDayPickedClosure { [weak self] day in
            self?.changeDisplayingDay(day)
        }

        initDisplayingDayObserving()
    }

    func displayingDayChanged() {
//        isAbleToChangePage = false
//
//        switch displayingWeekEnum {
//        case .left:
//            displayingWeeksData.centerDisplayingWeek = displayingWeeksData.leftDisplayingWeek
//        case .center:
//            ()
//        case .right:
//            displayingWeeksData.centerDisplayingWeek = displayingWeeksData.rightDisplayingWeek
//        }
//
//        displayingWeeksData.leftDisplayingWeek = displayingWeeksData.centerDisplayingWeek.previousWeek
//        displayingWeeksData.rightDisplayingWeek = displayingWeeksData.centerDisplayingWeek.nextWeek
//
//        displayingWeekEnum = .center
//
//        isAbleToChangePage = true
    }

    func viewDidAppear() {
        loadDisplayingSchedule()
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    private func loadDisplayingSchedule() {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]

        guard let startOfWeek = displayingDay.startOfWeek, let endOfWeek = displayingDay.endOfWeek else {
            return
        }

        let startOfWeekFormatted = formatter.string(from: startOfWeek)
        let endOfWeekFormatted = formatter.string(from: endOfWeek)

        switch displayingSchedule.type {
        case .teacher:
            getTeacherLessonsUseCase.execute(
                teacherId: displayingSchedule.id,
                startDate: startOfWeekFormatted,
                endDate: endOfWeekFormatted
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.displayingDaysData.centerDisplayingDayData = response.lessons
                case .failure(let error):
                    self?.processError(error)
                }
            }
        case .group:
            getStudentGroupLessonsUseCase.execute(
                groupId: displayingSchedule.id,
                startDate: startOfWeekFormatted,
                endDate: endOfWeekFormatted
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.displayingDaysData.centerDisplayingDayData = response.lessons
                case .failure(let error):
                    self?.processError(error)
                }
            }
        case .classroom:
            getClassroomLessonsUseCase.execute(
                classroomId: displayingSchedule.id,
                startDate: startOfWeekFormatted,
                endDate: endOfWeekFormatted
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.displayingDaysData.centerDisplayingDayData = response.lessons
                case .failure(let error):
                    self?.processError(error)
                }
            }
        }
    }

    private func initDisplayingDayObserving() {
        $displayingDayEnum.sink { [weak self] _ in
            self?.isAbleToChangePage = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.isAbleToChangePage = false
            }
        }
        .store(in: &subscribers)
    }

    private func changeDisplayingDay(_ date: Date) {}
}
