//
//  ProfileVIewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var isAlertShowing = false
    @Published var isSuccessAlertShowing = false
    @Published private(set) var alertText = ""

    @Published var userRole: RoleEnum?

    @Published var sharedExternalUserProfileData = SharedProfileViewData()
    @Published var sharedStudentProfileData = SharedStudentViewData()
    @Published var sharedEmployeeProfileData = SharedEmployeeViewData()

    @Published private(set) var externalUserProfileData: User?

    private let getTokensUseCase: GetTokensUseCase
    private let getProfileExternalUseCase: GetProfileExternalUseCase
    private let getProfileStudentUseCase: GetProfileStudentUseCase
    private let getUserRoleUseCase: GetUserRoleUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        getTokensUseCase: GetTokensUseCase,
        getProfileExternalUseCase: GetProfileExternalUseCase,
        getProfileStudentUseCase: GetProfileStudentUseCase,
        getUserRoleUseCase: GetUserRoleUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.getTokensUseCase = getTokensUseCase
        self.getProfileExternalUseCase = getProfileExternalUseCase
        self.getProfileStudentUseCase = getProfileStudentUseCase
        self.getUserRoleUseCase = getUserRoleUseCase
        self.logoutUseCase = logoutUseCase
    }

    private func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }

    func viewDidAppear() {
        getProfileRoleUser()
    }

    func getProfileRoleUser() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getUserRoleUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let role):
                        self.userRole = .getValueFromString(role)
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }

    func getExternalUserProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getProfileExternalUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let externalUser):
                        print(externalUser)
                        updateExternalUserProfileData(profileData: externalUser)
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }

    func logout() {
        logoutUseCase.execute(token: "")
    }

    private func updateExternalUserProfileData(profileData: User) {
        externalUserProfileData = profileData
        sharedExternalUserProfileData.userFIO =
            profileData.name + " " + profileData.surname + " " + profileData.patronymic
        sharedExternalUserProfileData.emailText = profileData.email
        sharedExternalUserProfileData.userRole =
            (RoleEnum.getValueFromString(profileData.role)?.networkingValue)!
        sharedExternalUserProfileData.acccountStatus = (AccountStatusEnum.getValueFromString(profileData.accountStatus)?.networkingValue)!
        sharedExternalUserProfileData.genderType = GenderProfileEnum.getValueFromString(profileData.sex)!.rawValue
    }

    func getStudentUserProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getProfileStudentUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let studentUser):
                        print(studentUser)
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
