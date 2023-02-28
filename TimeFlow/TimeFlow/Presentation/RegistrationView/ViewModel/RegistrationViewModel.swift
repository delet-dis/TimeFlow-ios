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

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""
    @Published private(set) var areFieldsValid = false

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

        initFieldsObserving()
    }

    private func resetValidState() {
        sharedRegistrationFieldsState.isEmailValid = true
        sharedRegistrationFieldsState.isPasswordValid = true
        sharedRegistrationFieldsState.isMiddleNameValid = true
        sharedRegistrationFieldsState.isSecondNameValid = true
        sharedRegistrationFieldsState.isPasswordConfirmationValid = true
        sharedRegistrationFieldsState.isFirstNameValid = true
        sharedRegistrationFieldsState.isGenderValid = true
        sharedStudentRegistrationState.isGroupNumberValid = true
        sharedStudentRegistrationState.isStudentNumberValid = true
        sharedTeacherRegistrationState.isContractNumberValid = true
    }

    private func initFieldsObserving() {
        initEmployeeNumberObserver()
        initViewDisplayingModeIndexObserver()
        initFirstNameObserver()
        initSecondNameObserver()
        initMiddleNameObserver()
        initEmailObserver()
        initPasswordObserver()
        initGenderObserver()
        initSecondPasswordObserver()
        initStudentsGroupObserver()
        initStudentsNumberObserver()
    }

    private func initViewDisplayingModeIndexObserver() {
        $viewDisplayingModeIndex.sink { [weak self] value in
            if let enumValue = RegistrationViewDisplayingModeEnum(rawValue: value) {
                self?.viewDisplayingMode = enumValue
            }
        }
        .store(in: &subscribers)
    }

    private func initEmployeeNumberObserver() {
        sharedTeacherRegistrationData.contractNumber.publisher.sink { [weak self] _ in
            self?.sharedTeacherRegistrationState.isContractNumberValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initStudentsGroupObserver() {
        sharedStudentRegistrationData.groupNumber.publisher.sink { [weak self] _ in
            self?.sharedStudentRegistrationState.isGroupNumberValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initStudentsNumberObserver() {
        sharedStudentRegistrationData.studentNumber.publisher.sink { [weak self] _ in
            self?.sharedStudentRegistrationState.isStudentNumberValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initFirstNameObserver() {
        sharedRegistrationData.firstName.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isFirstNameValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initSecondNameObserver() {
        sharedRegistrationData.secondName.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isSecondNameValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initMiddleNameObserver() {
        sharedRegistrationData.middleName.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isMiddleNameValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initEmailObserver() {
        sharedRegistrationData.emailText.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isEmailValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initPasswordObserver() {
        sharedRegistrationData.passwordText.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isPasswordValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initSecondPasswordObserver() {
        sharedRegistrationData.confirmPasswordText.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isPasswordConfirmationValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    private func initGenderObserver() {
        sharedRegistrationData.genderType.words.publisher.sink { [weak self] _ in
            self?.sharedRegistrationFieldsState.isGenderValid = true
            self?.validateFields()
        }.store(in: &subscribers)
    }

    @discardableResult private func validateFields() -> Bool {
        if !AuthorizationOrRegistrationDataHelper
            .isFirstNameValid(sharedRegistrationData.firstName) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isEmailValid(sharedRegistrationData.emailText) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper.isGenderValid(
            GenderEnum(rawValue: sharedRegistrationData.genderType)
        ) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isSecondNameValid(sharedRegistrationData.secondName) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isMiddleNameValid(sharedRegistrationData.middleName) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isPasswordValid(sharedRegistrationData.passwordText) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isPasswordValid(sharedRegistrationData.confirmPasswordText) {
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .arePasswordsValid(
                firstPassword: sharedRegistrationData.passwordText,
                passwordConfirmation: sharedRegistrationData.confirmPasswordText
            ) {
            areFieldsValid = false
            return false
        }

        areFieldsValid = true
        return true
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

    private func handleSuccessRegistrationRequestReponse() {}

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
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

    func viewDidDisappear() {
        viewDisplayingModeIndex = RegistrationViewDisplayingModeEnum.teacher.rawValue
    }
}
