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
    @Published var studentGroups: [StudentGroup] = []

    private let registerStudentUseCase: RegisterStudentUseCase
    private let registerTeacherUseCase: RegisterTeacherUseCase
    private let getStudentGroupsUseCase: GetStudentGroupsUseCase
    private let registerExternalUserUseCase: RegisterExternalUserUseCase

    private var subscribers: Set<AnyCancellable> = []

    init(
        registerStudentUseCase: RegisterStudentUseCase,
        registerTeacherUseCase: RegisterTeacherUseCase,
        registerExternalUserUseCase: RegisterExternalUserUseCase,
        getStudentGroupUseCase: GetStudentGroupsUseCase
    ) {
        self.registerStudentUseCase = registerStudentUseCase
        self.registerTeacherUseCase = registerTeacherUseCase
        self.registerExternalUserUseCase = registerExternalUserUseCase
        self.getStudentGroupsUseCase = getStudentGroupUseCase

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

        switch viewDisplayingMode {
        case .teacher:
            sharedTeacherRegistrationState.isContractNumberValid = true
        case .student:
            sharedStudentRegistrationState.isStudentNumberValid = true
        case .externalUser:
            ()
        }
    }

    private func initFieldsObserving() {
        initViewDisplayingModeIndexObserver()
        initRegistrationDataObserver()
        initTeacherRegistrationDataObserver()
        initStudentRegistrationDataObserver()
    }

    private func initViewDisplayingModeIndexObserver() {
        $viewDisplayingModeIndex.sink { [weak self] value in
            DispatchQueue.runAsyncOnMainWithDelay(delay: .short) {
                if let enumValue = RegistrationViewDisplayingModeEnum(rawValue: value) {
                    self?.viewDisplayingMode = enumValue

                    self?.resetValidState()
                    self?.validateFields()
                }
            }
        }
        .store(in: &subscribers)
    }

    private func initRegistrationDataObserver() {
        $sharedRegistrationData.sink { [weak self] _ in
            self?.isAlertShowing = false

            DispatchQueue.runAsyncOnMainWithDelay(delay: .short) {
                self?.resetValidState()
                self?.validateFields()
            }
        }.store(in: &subscribers)
    }

    private func initStudentRegistrationDataObserver() {
        $sharedStudentRegistrationData.sink { [weak self] _ in
            self?.isAlertShowing = false

            DispatchQueue.runAsyncOnMainWithDelay(delay: .short) {
                self?.resetValidState()
                self?.validateFields()
            }

        }.store(in: &subscribers)
    }

    func cleareFields() {
        sharedRegistrationData.secondName = ""
        sharedRegistrationData.firstName = ""
        sharedRegistrationData.middleName = ""
        sharedRegistrationData.genderType = GenderEnum.none.rawValue
        sharedRegistrationData.emailText = ""
        sharedRegistrationData.passwordText = ""
        sharedRegistrationData.confirmPasswordText = ""
        sharedTeacherRegistrationData.contractNumber = ""
        sharedStudentRegistrationData.studentNumber = ""
        sharedStudentRegistrationData.groupId = ""
    }

    private func initTeacherRegistrationDataObserver() {
        $sharedTeacherRegistrationData.sink { [weak self] _ in
            self?.isAlertShowing = false

            DispatchQueue.runAsyncOnMainWithDelay(delay: .short) {
                self?.resetValidState()
                self?.validateFields()
            }

        }.store(in: &subscribers)
    }

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    @discardableResult private func validateFields() -> Bool {
        if !AuthorizationOrRegistrationDataHelper
            .isFirstNameValid(sharedRegistrationData.firstName) {
            sharedRegistrationFieldsState.isFirstNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isSecondNameValid(sharedRegistrationData.secondName) {
            sharedRegistrationFieldsState.isSecondNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isMiddleNameValid(sharedRegistrationData.middleName) {
            sharedRegistrationFieldsState.isMiddleNameValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isEmailValid(sharedRegistrationData.emailText) {
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
            .isPasswordValid(sharedRegistrationData.passwordText) {
            sharedRegistrationFieldsState.isPasswordValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .isPasswordValid(sharedRegistrationData.confirmPasswordText) {
            sharedRegistrationFieldsState.isPasswordConfirmationValid = false
            areFieldsValid = false
            return false
        }

        if !AuthorizationOrRegistrationDataHelper
            .arePasswordsValid(
                firstPassword: sharedRegistrationData.passwordText,
                passwordConfirmation: sharedRegistrationData.confirmPasswordText
            ) {
            sharedRegistrationFieldsState.arePasswordsEqual = false
            areFieldsValid = false
            return false
        }

        switch viewDisplayingMode {
        case .teacher:
            if !AuthorizationOrRegistrationDataHelper
                .isTeacherNumberValid(sharedTeacherRegistrationData
                                        .contractNumber) {
                sharedTeacherRegistrationState.isContractNumberValid = false
                areFieldsValid = false
                return false
            }
        case .student:
            if !AuthorizationOrRegistrationDataHelper
                .isStudentNumberValid(sharedStudentRegistrationData
                                        .studentNumber) {
                sharedStudentRegistrationState.isStudentNumberValid = false
                areFieldsValid = false
                return false
            }
        case .externalUser:
            ()
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
            studentNumber: sharedStudentRegistrationData.studentNumber,
            groupId: sharedStudentRegistrationData.groupId
        )
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    private func processTeacherRegistrationRequest() {
        guard let request = createTeacherRegistrationRequest() else {
            return
        }
        LoaderView.startLoading()

        registerTeacherUseCase.execute(
            teacherRegistrationRequest: request
        ) { [weak self] result in
            LoaderView.endLoading()

            if case .failure(let error) = result {
                self?.processError(error)
            }
        }
    }

    private func processStudentRegistrationRequest() {
        guard let request = createStudentResitrationRequest() else {
            return
        }
        LoaderView.startLoading()

        registerStudentUseCase.execute(
            studentRegistrationRequest: request
        ) { [weak self] result in
            LoaderView.endLoading()

            if case .failure(let error) = result {
                self?.processError(error)
            }
        }
    }

    private func processExternalUserRegistrationRequest() {
        guard let request = createExternalUserRegistrationRequest() else {
            return
        }
        LoaderView.startLoading()

        registerExternalUserUseCase.execute(
            externalUserRegistrationRequest: request
        ) { [weak self] result in
            LoaderView.endLoading()

            if case .failure(let error) = result {
                self?.processError(error)
            }
        }
    }

    func register() {
        switch viewDisplayingMode {
        case .teacher:
            processTeacherRegistrationRequest()

        case .student:
            processStudentRegistrationRequest()

        case .externalUser:
            processExternalUserRegistrationRequest()
        }
    }

    func viewDidDisappear() {
        viewDisplayingModeIndex = RegistrationViewDisplayingModeEnum.teacher.rawValue
        studentGroups = []
    }

    func viewDidAppear() {
        getStudentGroups()
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
}
