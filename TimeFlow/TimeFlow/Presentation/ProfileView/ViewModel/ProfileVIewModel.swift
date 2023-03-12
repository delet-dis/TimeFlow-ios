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
    @Published var userRole = ""

    private let getTokensUseCase: GetTokensUseCase
    private let getProfileExternalUseCase: GetProfileExternalUseCase
    private let getRoleUserUseCase: GetRoleUserUseCase

    init(
        getTokensUseCase: GetTokensUseCase,
        getProfileExternalUseCase: GetProfileExternalUseCase,
        getRoleUserUseCase: GetRoleUserUseCase
    ) {
        self.getTokensUseCase = getTokensUseCase
        self.getProfileExternalUseCase = getProfileExternalUseCase
        self.getRoleUserUseCase = getRoleUserUseCase
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }
    
    func viewDidAppear() {
        getProfileRoleUser()
    }
    
    func getProfileRoleUser(){
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getRoleUserUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let role):
                        self.userRole = role
                    case .failure(let error):
                        processError(error)
                    }
                    
                }
            case .failure(let error):
                processError(error)
            }
        }
    }
        


    func updateExternalUserProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getProfileExternalUseCase.execute(token: token) { [self] result in
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
