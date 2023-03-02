//
//  MainViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import Foundation
import SwiftyUserDefaults

class MainViewModel: ObservableObject {
    @Published private(set) var mainViewDispalyingMode: MainViewDisaplyingModeEnum = .authorization

    private(set) var loginComponent: LoginComponent?

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    private var authStatusObserver: DefaultsDisposable?
    private let getAuthStatusUseCase: GetAuthStatusUseCase

    init(
        getAuthStatusUseCase: GetAuthStatusUseCase,
        loginComponent: LoginComponent? = nil
    ) {
        self.getAuthStatusUseCase = getAuthStatusUseCase
        self.loginComponent = loginComponent

        getAuthStatus()

        observeAuthStatus()
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    func processAuthStatus(isAuthorized: Bool) {
        if isAuthorized {
            mainViewDispalyingMode = .homeScreen
        } else {
            mainViewDispalyingMode = .authorization
        }
    }

    func getAuthStatus() {
        getAuthStatusUseCase.execute { [self] result in
            switch result {
            case .success(let authStatus):
                processAuthStatus(isAuthorized: authStatus)
            case .failure(let error):
                processError(error)
            }
        }
    }

    private func observeAuthStatus() {
        authStatusObserver = Defaults.observe(\.isAuthorized) { [self] update in
            if let isAuthorized = update.newValue,
               let isAuthorizedUnwrapped = isAuthorized {
                if isAuthorizedUnwrapped {
                    mainViewDispalyingMode = .homeScreen
                } else {
                    mainViewDispalyingMode = .authorization
                }
            }
        }
    }
}
