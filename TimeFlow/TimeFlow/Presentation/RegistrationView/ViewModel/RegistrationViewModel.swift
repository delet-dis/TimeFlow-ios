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
    @Published var arrayStudentsGroups: [StudentsGroup] = []

    private let registerStudentUseCase: RegisterStudentUseCase
    private let registerTeacherUseCase: RegisterTeacherUseCase
    private let getStudentGroupUseCase: GroupStudentUseCase
    private let registerExternalUserUseCase: RegisterExternalUserUseCase

    private var subscribers: Set<AnyCancellable> = []

    init(
        registerStudentUseCase: RegisterStudentUseCase,
        registerTeacherUseCase: RegisterTeacherUseCase,
        registerExternalUserUseCase: RegisterExternalUserUseCase,
        getStudentGroupUseCase: GroupStudentUseCase
    ) {
        self.registerStudentUseCase = registerStudentUseCase
        self.registerTeacherUseCase = registerTeacherUseCase
        self.registerExternalUserUseCase = registerExternalUserUseCase
        self.getStudentGroupUseCase = getStudentGroupUseCase

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
        initViewDisplayingModeIndexObserver()

        initRegistrationDataObserver()
    }

    private func initViewDisplayingModeIndexObserver() {
        $viewDisplayingModeIndex.sink { [weak self] value in
            if let enumValue = RegistrationViewDisplayingModeEnum(rawValue: value) {
                self?.viewDisplayingMode = enumValue
            }
        }
        .store(in: &subscribers)
    }

    private func initRegistrationDataObserver() {
        $sharedRegistrationData.sink { [weak self] _ in
            DispatchQueue.runAsyncOnMainWithDelay(delay: .short) {
                self?.resetValidState()
                self?.validateFields()
            }
        }.store(in: &subscribers)
    }

    @discardableResult private func validateFields() -> Bool {
        if !AuthorizationOrRegistrationDataHelper
            .isFirstNameValid(sharedRegistrationData.firstName)
        {
            sharedRegistrationFieldsState.isFirstNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isSecondNameValid(sharedRegistrationData.secondName)
        {
            sharedRegistrationFieldsState.isSecondNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isMiddleNameValid(sharedRegistrationData.middleName)
        {
            sharedRegistrationFieldsState.isMiddleNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isEmailValid(sharedRegistrationData.emailText)
        {
            sharedRegistrationFieldsState.isEmailValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper.isGenderValid(
            GenderEnum(rawValue: sharedRegistrationData.genderType)
        ) {
            sharedRegistrationFieldsState.isGenderValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isPasswordValid(sharedRegistrationData.passwordText)
        {
            sharedRegistrationFieldsState.isPasswordValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isPasswordValid(sharedRegistrationData.confirmPasswordText)
        {
            sharedRegistrationFieldsState.isPasswordConfirmationValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .arePasswordsValid(
                firstPassword: sharedRegistrationData.passwordText,
                passwordConfirmation: sharedRegistrationData.confirmPasswordText
            )
        {
            sharedRegistrationFieldsState.arePasswordsEqual = false
            areFieldsValid = false
            return false
        }

        areFieldsValid = true
        return true
    }

    private func createTeacherRegistrationRequest() -> TeacherRegistrationRequest? {
        guard let sex = GenderEnum(rawValue: sharedRegistrationData.genderType)?.networkingValue else {
            return nil
        }

        return TeacherRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sex,
            contractNumber: sharedTeacherRegistrationData.contractNumber
        )
    }

    private func createExternalUserRegistrationRequest() -> ExternalUserRegistrationRequest? {
        guard let sex = GenderEnum(rawValue: sharedRegistrationData.genderType)?.networkingValue else {
            return nil
        }

        return ExternalUserRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sex
        )
    }

    private func createStudentResitrationRequest() -> StudentRegistrationRequest? {
        guard let sex = GenderEnum(rawValue: sharedRegistrationData.genderType)?.networkingValue else {
            return nil
        }

        return StudentRegistrationRequest(
            email: sharedRegistrationData.emailText,
            name: sharedRegistrationData.firstName,
            surname: sharedRegistrationData.secondName,
            patronymic: sharedRegistrationData.middleName,
            password: sharedRegistrationData.passwordText,
            sex: sex,
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
            guard let request = createTeacherRegistrationRequest() else {
                return
            }

            registerTeacherUseCase.execute(
                teacherRegistrationRequest: request
            ) { [weak self] result in
                switch result {
                case .success:
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                }
            }

        case .student:
            guard let request = createStudentResitrationRequest() else {
                return
            }

            registerStudentUseCase.execute(
                studentRegistrationRequest: request
            ) { [weak self] result in
                switch result {
                case .success:
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                }
            }

        case .externalUser:
            guard let request = createExternalUserRegistrationRequest() else {
                return
            }
            print("Yeee")
            registerExternalUserUseCase.execute(
                externalUserRegistrationRequest: request
            ) { [weak self] result in
                switch result {
                case .success:
                    print("Ok")
                    self?.handleSuccessRegistrationRequestReponse()
                case .failure(let error):
                    self?.processError(error)
                    print(error)
                }
            }
        }
    }

    func viewDidDisappear() {
        viewDisplayingModeIndex = RegistrationViewDisplayingModeEnum.teacher.rawValue
        arrayStudentsGroups = []
    }

    func getStudentGroup() -> [StudentsGroup] {
        getStudentGroupUseCase.execute { [weak self] result in
            switch result {
            case .success(let groups):
                groups.forEach { group in
                    self?.arrayStudentsGroups.append(group)
                }
                print("Ok")
            case .failure(let error):
                print(error)
            }
        }
        return arrayStudentsGroups
    }
}
