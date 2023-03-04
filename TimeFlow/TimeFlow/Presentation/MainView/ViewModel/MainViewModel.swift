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

    let loginComponent: LoginComponent?
    let homeComponent: HomeComponent?

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    @Published private(set) var isSplashDisplaying = true

    private var authStatusObserver: DefaultsDisposable?
    private let getAuthStatusUseCase: GetAuthStatusUseCase

    init(
        getAuthStatusUseCase: GetAuthStatusUseCase,
        loginComponent: LoginComponent? = nil,
        homeComponent: HomeComponent? = nil
    ) {
        self.getAuthStatusUseCase = getAuthStatusUseCase
        self.loginComponent = loginComponent
        self.homeComponent = homeComponent

        getAuthStatus()

        observeAuthStatus()
    }

    func viewDidAppear() {
        startSplashCountdown()
    }

    private func startSplashCountdown() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isSplashDisplaying = false
        }
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
