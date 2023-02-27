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

    private let registerUseCase: RegisterUseCase

    let registrationComponent: RegistrationComponent?
    private var subscribers: Set<AnyCancellable> = []

    init(
        registrationComponent: RegistrationComponent? = nil,
        registerUseCase: RegisterUseCase) {
        self.registrationComponent = registrationComponent
        self.registerUseCase = registerUseCase
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

    func register() {
        switch viewDisplayingMode {
        case .teacher:
            registerUseCase.executeTeacher(request: TeacherRegisterCredentials(
                                            email: sharedRegistrationData.emailText,
                                            name: sharedRegistrationData.firstName,
                                            surname: sharedRegistrationData.secondName,
                                            patronymic: sharedRegistrationData.middleName,
                                            sex: sharedRegistrationData.genderType,
                                            password: sharedRegistrationData.passwordText,
                                            contractNumber: sharedTeacherRegistrationData.contractNumber)) {
                [weak self] result in
                switch result {
                case .success(let response):
                    // Go in homeScreen
                    break
                case .failure(let error):
                    break
                }
            }
        case .student:
            registerUseCase.executeStudent(request: StudentRegisterCredentials(
                                            email: sharedRegistrationData.emailText,
                                            name: sharedRegistrationData.firstName,
                                            surname: sharedRegistrationData.secondName,
                                            patronymic: sharedRegistrationData.middleName,
                                            password: sharedRegistrationData.passwordText,
                                            groupId: sharedStudentRegistrationData.groupNumber,
                                            sex: sharedRegistrationData.genderType)) { [weak self] result in
                switch result {
                case .success(let response):
                    // Go in homeScreen
                    break
                case .failure(let error):
                    break
                }
            }
        case .externalUser:
            registerUseCase.executeExternalUser(request: ExternalUserCredentials(
                                                    email: sharedRegistrationData.emailText,
                                                    name: sharedRegistrationData.firstName,
                                                    surname: sharedRegistrationData.secondName,
                                                    patronymic: sharedRegistrationData.middleName,
                                                    password: sharedRegistrationData.passwordText,
                                                    sex: sharedRegistrationData.genderType)) { [weak self] result in
                switch result {
                case .success(let response):
                    // Go in homeScreen
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
}
