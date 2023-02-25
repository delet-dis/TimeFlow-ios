//
//  RegistrationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Combine
import Foundation

class RegistrationViewModel: ObservableObject {
    @Published private(set) var viewDisplayingMode = RegistrationViewDisplayingModeEnum.teacher
    @Published var viewDisplayingModeIndex = RegistrationViewDisplayingModeEnum.teacher.rawValue

    @Published var sharedRegistrationData = SharedRegistrationViewData()
    @Published var sharedRegistrationFieldsState = SharedRegistrationViewState()

    @Published var sharedTeacherRegistrationData = TeacherRegistationViewData()
    @Published var sharedTeacherRegistrationState = TeacherRegistationViewState()

    @Published var sharedStudentRegistrationData = StudentRegistrationViewData()
    @Published var sharedStudentRegistrationState = StudentRegistationViewState()

    let registrationComponent: RegistrationComponent?
    private var subscribers: Set<AnyCancellable> = []

    init(
        registrationComponent: RegistrationComponent? = nil
    ) {
        self.registrationComponent = registrationComponent

        initViewDisplayingModeIndexObserver()
    }

    private func initViewDisplayingModeIndexObserver() {
        $viewDisplayingModeIndex.sink { [weak self] value in
            if let enumValue = RegistrationViewDisplayingModeEnum(rawValue: value) {
                self?.viewDisplayingMode = enumValue
            }
        }
        .store(in: &subscribers)
    }

    func changeRole(role: RegistrationViewDisplayingModeEnum) {
        viewDisplayingMode = role
    }
}
