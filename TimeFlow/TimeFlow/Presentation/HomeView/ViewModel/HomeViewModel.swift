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
    private let getProfileUseCase: GetProfileUseCase
    private let getTokensUseCase: GetTokensUseCase

    init(
        getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase,
        saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase,
        getProfileUseCase: GetProfileUseCase,
        getTokensUseCase: GetTokensUseCase,
        profileComponent: ProfileComponent? = nil
    ) {
        self.getDisplayingScheduleUseCase = getDisplayingScheduleUseCase
        self.saveDisplayingScheduleUseCase = saveDisplayingScheduleUseCase
        self.getProfileUseCase = getProfileUseCase
        self.getTokensUseCase = getTokensUseCase

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
                    self?.getTokensUseCase.execute(tokenType: .auth){[weak self] result in
                        switch result {
                        case .success(let token):
                            self?.getProfileUseCase.execute(token: token){[weak self] result in
                                switch result{
                                case .success(let user):
                                    switch RoleEnum.getValueFromString(user.role){
                                    case .student
                                    }
                                case .failure(let error):
                                }
                            }
                        case .failure(let error):
                            self?.processError(error)
                        }
                    }
                }
            case .failure(let error):
                self?.processError(error)
            }
        }
    }

    private func processDisplayingSchedule(_ displayingSchedule: DisplayingSchedule?) {
        if let displayingSchedule = displayingSchedule {
            scheduleViewModel = .init(displayingSchedule: displayingSchedule)

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
