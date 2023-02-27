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

    private let registerStudentUseCase: RegisterStudentUseCase
    private let registerTeacherUseCase: RegisterTeacherUseCase
    private let registerExternalUserUseCase: RegisterExternalUserUseCase

    private var subscribers: Set<AnyCancellable> = []

    init(
        registerStudentUseCase: RegisterStudentUseCase,
        registerTeacherUseCase: RegisterTeacherUseCase,
        registerExternalUserUseCase: RegisterExternalUserUseCase
    ) {
        self.registerStudentUseCase = registerStudentUseCase
        self.registerTeacherUseCase = registerTeacherUseCase
        self.registerExternalUserUseCase = registerExternalUserUseCase

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

    private func createTeacherRegistrationRequest() -> TeacherRegistrationRequest {
        TeacherRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sharedRegistrationData.genderType,
            contractNumber: sharedTeacherRegistrationData.contractNumber
        )
    }

    private func createExternalUserRegistrationRequest() -> ExternalUserRegistrationRequest {
        ExternalUserRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sharedRegistrationData.genderType
        )
    }

    private func createStudentResitrationRequest() -> StudentRegistrationRequest {
        StudentRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sharedRegistrationData.genderType,
            groupId: sharedStudentRegistrationData.groupNumber
        )
    }

    private func handleSuccessRegistrationRequestReponse() {

    }

    private func processError(_ error: Error) {
        
    }

    func register() {
        switch viewDisplayingMode {
        case .teacher:
            registerTeacherUseCase.execute(
                teacherRegistrationRequest: createTeacherRegistrationRequest()
            ) { [weak self] result in
                switch result {
                case .success:
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                }
            }

        case .student:
            registerStudentUseCase.execute(
                studentRegistrationRequest: createStudentResitrationRequest()
            ) { [weak self] result in
                switch result {
                case .success:
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                }
            }

        case .externalUser:
            registerExternalUserUseCase.execute(
                externalUserRegistrationRequest: createExternalUserRegistrationRequest()
            ) { [weak self] result in
                switch result {
                case .success:
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                }
            }
        }
    }
}
