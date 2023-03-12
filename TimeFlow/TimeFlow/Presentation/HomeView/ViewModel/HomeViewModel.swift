//
//  HomeViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Combine
import Foundation
import SwiftyUserDefaults

class HomeViewModel: ObservableObject {
    @Published private(set) var scheduleViewModel: ScheduleViewModel?
    @Published private(set) var isScheduleDisplaying = true

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    let profileComponent: ProfileComponent?

    private var displayingScheduleObserver: DefaultsDisposable?

    private let getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase
    private let saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase
    private let getUserRoleUseCase: GetUserRoleUseCase
    private let getProfileStudentUseCase: GetProfileStudentUseCase
    private let getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase
    private let getTokensUseCase: GetTokensUseCase

    private let getTeacherLessonsUseCase: GetTeacherLessonsUseCase
    private let getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase
    private let getClassroomLessonsUseCase: GetClassroomLessonsUseCase

    init(
        getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase,
        saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase,
        getUserRoleUseCase: GetUserRoleUseCase,
        getProfileStudentUseCase: GetProfileStudentUseCase,
        getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase,
        getTokensUseCase: GetTokensUseCase,

        getTeacherLessonsUseCase: GetTeacherLessonsUseCase,
        getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase,
        getClassroomLessonsUseCase: GetClassroomLessonsUseCase,

        profileComponent: ProfileComponent? = nil
    ) {
        self.getDisplayingScheduleUseCase = getDisplayingScheduleUseCase
        self.saveDisplayingScheduleUseCase = saveDisplayingScheduleUseCase
        self.getUserRoleUseCase = getUserRoleUseCase
        self.getProfileStudentUseCase = getProfileStudentUseCase
        self.getProfileEmployeeUseCase = getProfileEmployeeUseCase
        self.getTokensUseCase = getTokensUseCase

        self.getTeacherLessonsUseCase = getTeacherLessonsUseCase
        self.getStudentGroupLessonsUseCase = getStudentGroupLessonsUseCase
        self.getClassroomLessonsUseCase = getClassroomLessonsUseCase

        self.profileComponent = profileComponent

        initDisplayingScheduleObserver()
    }

    func viewDidAppear() {
        getDisplayingSchedule()
    }

    private func initDisplayingScheduleObserver() {
        displayingScheduleObserver = Defaults.observe(\.displayingSchedule) { [self] update in
            if let displayingSchedule = update.newValue {
                processDisplayingSchedule(displayingSchedule)
            }
        }
    }

    private func getDisplayingSchedule() {
        LoaderView.startLoading()

        getDisplayingScheduleUseCase.execute { [weak self] result in
            LoaderView.endLoading()

            switch result {
            case .success(let displayingSchedule):
                self?.processDisplayingSchedule(displayingSchedule)

                if displayingSchedule == nil {
                    self?.loadScheduleToDisplay()
                }
            case .failure(let error):
                self?.processError(error)
            }
        }
    }

    // swiftlint:disable:next cyclomatic_complexity function_body_length
    private func loadScheduleToDisplay() {
        LoaderView.startLoading()

        let showUnableToLoadScheduleMessage = { [weak self] in
            self?.processError(
                NSError.createErrorWithLocalizedDescription(
                    R.string.localizable.pleaseSpecifyPreferredScheduleInProfile()
                )
            )
        }

        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            switch result {
            case .success(let token):
                self?.getUserRoleUseCase.execute(token: token) { [weak self] result in
                    switch result {
                    case .success(let role):
                        switch RoleEnum.getValueFromString(role) {
                        case .student:
                            self?.getProfileStudentUseCase.execute(
                                token: token
                            ) { [weak self] result in
                                LoaderView.endLoading()

                                switch result {
                                case .success(let student):
                                    self?.saveDisplayingScheduleUseCase.execute(
                                        displayingSchedule: .init(
                                            type: .group,
                                            id: student.group.id
                                        )
                                    )
                                case .failure:
                                    showUnableToLoadScheduleMessage()
                                }
                            }
                        case .employee:
                            self?.getProfileEmployeeUseCase.execute(
                                token: token
                            ) { [weak self] result in
                                LoaderView.endLoading()

                                switch result {
                                case .success(let employee):
                                    self?.saveDisplayingScheduleUseCase.execute(
                                        displayingSchedule: .init(
                                            type: .teacher,
                                            id: employee.userInfo.role
                                        )
                                    )
                                case .failure:
                                    showUnableToLoadScheduleMessage()
                                }
                            }
                        case .none, .user:
                            showUnableToLoadScheduleMessage()
                        }
                    case .failure:
                        showUnableToLoadScheduleMessage()
                    }
                }
            case .failure:
                showUnableToLoadScheduleMessage()
            }
        }
    }

    private func processDisplayingSchedule(_ displayingSchedule: DisplayingSchedule?) {
        if let displayingSchedule = displayingSchedule {
            scheduleViewModel = .init(
                displayingSchedule: displayingSchedule,
                getTeacherLessonsUseCase: getTeacherLessonsUseCase,
                getStudentGroupLessonsUseCase: getStudentGroupLessonsUseCase,
                getClassroomLessonsUseCase: getClassroomLessonsUseCase
            )

            isScheduleDisplaying = true
        } else {
            isScheduleDisplaying = false
            scheduleViewModel = nil
        }
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }
}
