//
//  HomeViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Combine
import Foundation
import SwiftyUserDefaults
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published private(set) var scheduleViewModel: ScheduleViewModel?
    @Published private(set) var isScheduleDisplaying = true
    @Published var textShedule = ""

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

    @Published var teacherList: [TeachersList] = []
    @Published var classroomList: [ClassroomList] = []
    @Published var studentGroups: [StudentGroup] = []
    
    private let getTeacherLessonsUseCase: GetTeacherLessonsUseCase
    private let getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase
    private let getClassroomLessonsUseCase: GetClassroomLessonsUseCase
    
    private let getTeachersListUseCase: GetTeachersListUseCase
    private let getClassroomsListUseCase: GetClassroomsListUseCase
    private let getStudentGroupsUseCase: GetStudentGroupsUseCase

    init(
        getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase,
        saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase,
        getUserRoleUseCase: GetUserRoleUseCase,
        getProfileStudentUseCase: GetProfileStudentUseCase,
        getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase,
        getTokensUseCase: GetTokensUseCase,
        getTeachersListUseCase: GetTeachersListUseCase,
        getClassroomsListUseCase: GetClassroomsListUseCase,
        getStudentGroupsUseCase: GetStudentGroupsUseCase,

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
        
        self.getStudentGroupsUseCase = getStudentGroupsUseCase
        self.getTeachersListUseCase = getTeachersListUseCase
        self.getClassroomsListUseCase = getClassroomsListUseCase

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
    
    func getTeachearListData() {
        getTeachersListUseCase.execute { [weak self] result in
            switch result {
            case .success(let teacherList):
                self?.teacherList = teacherList
            case .failure(let error):
                self?.processError(error)
            }
        }
    }

    func getClassroomListData() {
        getClassroomsListUseCase.execute { [weak self] result in
            switch result {
            case .success(let classroomList):
                self?.classroomList = classroomList
            case .failure(let error):
                self?.processError(error)
            }
        }
    }

    func getStudentGroups() {
        getStudentGroupsUseCase.execute { [weak self] result in
            switch result {
            case .success(let groups):
                self?.studentGroups = groups.sorted(by: { $0.number ?? 0 < $1.number ?? 0 })
            case .failure(let error):
                self?.processError(error)
            }
        }
    }

    private func getDisplayingSchedule() {
        LoaderView.startLoading()

        getDisplayingScheduleUseCase.execute { [weak self] result in
            LoaderView.endLoading()

            switch result {
            case .success(let displayingSchedule):
                
                switch displayingSchedule?.type{
                    case .teacher:
                        ()
                    case .group:
                        ()
                    case .classroom:
                        ()
                    case .none:
                        ()
                }
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
