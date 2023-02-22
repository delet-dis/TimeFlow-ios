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
    @Published var viewDisplayingModeIndex = 0

    let registrationComponent: RegistrationComponent?
    private(set) var setStudentRegistrationViewClousure: (() -> Void)?
    private(set) var setTeacherRegistrationViewClousure: (() -> Void)?
    private(set) var setExternalUserRegistrationViewClousure: (() -> Void)?

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

    func pressStudentRegistrationViewClousure(_ studentRegistrationViewClosure: (() -> Void)? = nil) {
        setStudentRegistrationViewClousure = studentRegistrationViewClosure
    }

    func pressTeacherRegistrationViewClousure(_ teacherRegistrationViewClousure: (() -> Void)? = nil) {
        setTeacherRegistrationViewClousure = teacherRegistrationViewClousure
    }

    func pressExternalUserRegistrationViewClousure(
        _ externalUserRegistrationViewClousure: (() -> Void)? = nil
    ) {
        setExternalUserRegistrationViewClousure = externalUserRegistrationViewClousure
    }
    
    func changeRole(role: RegistrationViewDisplayingModeEnum ){
        viewDisplayingMode = role
    }
    
}


