//
//  AuthorizationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation

class AuthorizationViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""

    private let loginUseCase: LoginUseCase

    private(set) var setRegisrationViewClousure: (() -> Void)?

    @Published private(set) var isEmailValid = true
    @Published private(set) var isPasswordValid = true
    @Published private(set) var areFieldsValid = false

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func resetValidation() {
        isEmailValid = true
        isPasswordValid = true
    }

    func cleanFields() {
        resetValidation()

        emailText = ""
        passwordText = ""
    }

    private func checkValidFieldds() -> Bool {
        // Validation Check
        return true
    }

    func setRegistrationViewClousure(_ registrationViewClosure: (() -> Void)? = nil) {
        setRegisrationViewClousure = registrationViewClosure
    }

    func login() {
        if checkValidFieldds() {
            loginUseCase.execute(
                userCredentials: UserCredentials(
                    email: emailText,
                    password: passwordText
                )
            ) { [weak self] result in
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
