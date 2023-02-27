//
//  AuthorizationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Combine
import Foundation

class AuthorizationViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""

    private let loginUseCase: LoginUseCase

    private var subscribers: Set<AnyCancellable> = []

    private(set) var setRegisrationViewClousure: (() -> Void)?

    @Published private(set) var isEmailValid = true
    @Published private(set) var isPasswordValid = true
    @Published private(set) var areFieldsValid = false

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase

        initFieldsObserving()
    }

    private func resetValidation() {
        isEmailValid = true
        isPasswordValid = true
    }

    func cleanFields() {
        resetValidation()

        emailText = ""
        passwordText = ""
    }

    private func initFieldsObserving() {
        initEmailTextObserving()
        initPasswordTextObserving()
    }

    private func initEmailTextObserving() {
        $emailText.sink { [self] _ in
            self.isEmailValid = true

            validateFields()
        }.store(in: &subscribers)
    }

    private func initPasswordTextObserving() {
        $passwordText.sink { [self] _ in
            self.isPasswordValid = true

            validateFields()
        }.store(in: &subscribers)
    }

    @discardableResult
    private func validateFields() -> Bool {
        //        resetValidation()

        if !AuthorizationOrRegistrationDataHelper.isEmailValid(emailText) {
            areFieldsValid = false

            return false
        }

        if !AuthorizationOrRegistrationDataHelper.isPasswordValid(passwordText) {
            areFieldsValid = false

            return false
        }

        areFieldsValid = true

        return true
    }

    private func handleSuccessRegistrationRequestReponse() {

    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    func login() {
        if validateFields() {
            loginUseCase.execute(
                userCredentials: UserCredentials(
                    email: emailText,
                    password: passwordText
                )
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
