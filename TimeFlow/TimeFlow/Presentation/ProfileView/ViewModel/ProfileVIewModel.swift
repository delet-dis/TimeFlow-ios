//
//  ProfileVIewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var sharedProfileData = SharedProfileViewData()
    @Published var isAlertShowing = false
    @Published var isSuccessAlertShowing = false
    @Published private(set) var alertText = ""

    private let getTokenUseCase: GetTokenUseCase
    private let getProfileUseCase: GetProfileUseCase

    init(
        getTokenUseCase: GetTokenUseCase,
        getProfileUseCase: GetProfileUseCase
    ) {
        self.getTokenUseCase = getTokenUseCase
        self.getProfileUseCase = getProfileUseCase
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    func updateExternalUserProfileData() {
        getTokenUseCase.execute { [self] result in
            switch result {
            case .success(let token):
                getProfileUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let externalUser):
                        print(externalUser)
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }
}
