//
//  LoginViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published private(set) var viewDisplayingMode = LoginViewDisplayingModeEnum.authorization

    let authorizationComponent: AuthorizationComponent?
    let registrationComponent: RegistrationComponent?

    init(
        authorizationComponent: AuthorizationComponent? = nil,
        registrationComponent: RegistrationComponent? = nil
    ) {
        self.authorizationComponent = authorizationComponent
        self.registrationComponent = registrationComponent
    }

    func changeDisplayingMode() {
        switch viewDisplayingMode {
        case .authorization:
            viewDisplayingMode = .registration
        case .registration:
            viewDisplayingMode = .authorization
        }
    }
}
