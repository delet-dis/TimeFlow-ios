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

    @Published private(set) var isLessonsListDisplaying = true

    private var loadedSchedule: [String: [LessonResponse]] = [:]

    private let displayingSchedule: DisplayingSchedule

    private var displayingDay = Date.now

    private var subscribers: Set<AnyCancellable> = []

    private let getTeacherLessonsUseCase: GetTeacherLessonsUseCase
    private let getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase
    private let getClassroomLessonsUseCase: GetClassroomLessonsUseCase

    private var dateFormatter: ISO8601DateFormatter

    private var isWeekSwitcherTappedOnce = false

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

        weekSwitcherViewModel = .init()

        dateFormatter = .init()
        dateFormatter.formatOptions = [.withFullDate]

        weekSwitcherViewModel.setDayPickedClosure { [weak self] day in
            self?.weekSwitcherViewModel.toggleIsTapHappend()

            self?.isLessonsListDisplaying = false

            DispatchQueue.runAsyncOnMainWithDelay {
                self?.changeDisplayingDay(day)
            }
        }

        initDisplayingDayObserving()
    }

    func displayingDayChanged() {
        switch displayingDayEnum {
        case .left:
            changeDisplayingDay(displayingDay.previousDay)
        case .center:
            ()
        case .right:
            changeDisplayingDay(displayingDay.nextDay)
        }
    }

    func viewDidAppear() {
        loadScheduleForWeek(displayingDay) { [weak self] in
            guard let self = self else { return }
            self.changeDisplayingDay(self.displayingDay)
        }
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func loadScheduleForWeek(
        _ date: Date,
        isSilentLoading: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        if !isSilentLoading {
            LoaderView.startLoading()
        }

        loadedSchedule = [:]

        guard let startOfWeek = date.startOfWeek, let endOfWeek = date.endOfWeek else {
            return
        }

        let startOfWeekFormatted = dateFormatter.string(from: startOfWeek)
        let endOfWeekFormatted = dateFormatter.string(from: endOfWeek)

        switch displayingSchedule.type {
        case .teacher:
            getTeacherLessonsUseCase.execute(
                teacherId: displayingSchedule.id,
                startDate: startOfWeekFormatted,
                endDate: endOfWeekFormatted
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.splitLessonsResponseByDays(response.lessons, completion: completion)
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
                    self?.splitLessonsResponseByDays(response.lessons, completion: completion)
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
                    self?.splitLessonsResponseByDays(response.lessons, completion: completion)
                case .failure(let error):
                    self?.processError(error)
                }
            }
        }
    }

    private func splitLessonsResponseByDays(
        _ lessons: [LessonResponse],
        completion: (() -> Void)? = nil
    ) {
        lessons.forEach { lesson in
            if !(loadedSchedule[lesson.date]?.contains(where: { $0.id == lesson.id }) ?? false) {
                var lessonsCopy = loadedSchedule[lesson.date] ?? []
                lessonsCopy.append(lesson)

                loadedSchedule.updateValue(lessonsCopy, forKey: lesson.date)
            }
        }

        loadedSchedule.keys.forEach{ key in
            loadedSchedule[key] = loadedSchedule[key]?.sorted(by: {
                $0.timeslot.sequenceNumber < $1.timeslot.sequenceNumber
            })
        }

        completion?()

        LoaderView.endLoading()
    }

    private func initDisplayingDayObserving() {
        $displayingDayEnum.sink { [weak self] _ in
            self?.isAbleToChangePage = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.isAbleToChangePage = true
            }
        }
        .store(in: &subscribers)
    }

    private func changeDisplayingDay(_ date: Date) {
        isAbleToChangePage = false

        weekSwitcherViewModel.selectDate(date)

        guard let endOfWeek = displayingDay.endOfWeek,
              let startOfWeek = displayingDay.startOfWeek else {
            return
        }

        displayingDay = date

        let processLoadedData = { [weak self] in
            guard let self = self else { return }

            self.displayingDaysData.leftDisplayingDayData = self.loadedSchedule[
                self.dateFormatter.string(from: self.displayingDay.previousDay)
            ] ?? []
            self.displayingDaysData.centerDisplayingDayData = self.loadedSchedule[
                self.dateFormatter.string(from: self.displayingDay)
            ] ?? []
            self.displayingDaysData.rightDisplayingDayData = self.loadedSchedule[
                self.dateFormatter.string(from: self.displayingDay.nextDay)
            ] ?? []

            self.displayingDayEnum = .center

            self.isAbleToChangePage = true
            self.isLessonsListDisplaying = true
        }

        if date > endOfWeek || date < startOfWeek {
            loadScheduleForWeek(date, isSilentLoading: false) {
                processLoadedData()
            }
        }

        if date.startOfWeek == displayingDay {
            loadScheduleForWeek(displayingDay.previousWeek, isSilentLoading: true) {
                processLoadedData()
            }

            return
        }

        if date.endOfWeek == displayingDay {
            loadScheduleForWeek(displayingDay.nextWeek, isSilentLoading: true) {
                processLoadedData()
            }

            return
        }

        processLoadedData()
    }
}
