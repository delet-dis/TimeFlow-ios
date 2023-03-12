//
//  ProfileVIewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isAlertShowing = false
    @Published var isSuccessAlertShowing = false
    @Published private(set) var alertText = ""

    @Published var userRole: RoleEnum?

    @Published var sharedUserProfileData = SharedProfileViewData()
    @Published var sharedStudentProfileData = SharedStudentViewData()
    @Published var sharedEmployeeProfileData = SharedEmployeeViewData()

    @Published private(set) var externalUserProfileData: User?

    private let getTokensUseCase: GetTokensUseCase
    private let getProfileExternalUseCase: GetProfileExternalUseCase
    private let getProfileStudentUseCase: GetProfileStudentUseCase
    private let getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase
    private let getUserRoleUseCase: GetUserRoleUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        getTokensUseCase: GetTokensUseCase,
        getProfileExternalUseCase: GetProfileExternalUseCase,
        getProfileStudentUseCase: GetProfileStudentUseCase,
        getUserRoleUseCase: GetUserRoleUseCase,
        logoutUseCase: LogoutUseCase,
        getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase
    ) {
        self.getTokensUseCase = getTokensUseCase
        self.getProfileExternalUseCase = getProfileExternalUseCase
        self.getProfileStudentUseCase = getProfileStudentUseCase
        self.getUserRoleUseCase = getUserRoleUseCase
        self.logoutUseCase = logoutUseCase
        self.getProfileEmployeeUseCase = getProfileEmployeeUseCase
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
                        switch self.userRole {
                        case .student:
                            self.getStudentUserProfileData()
                        case .user:
                            self.getExternalUserProfileData()
                        case .employee:
                            self.getEmployeeProfileData()
                        case .none:
                            ()
                        }
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }

    private func getExternalUserProfileData() {
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

    private func getStudentUserProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getProfileStudentUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let studentUser):
                        print(studentUser)
                        updateStudentUserProfileData(profileData: studentUser)
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }

    private func getEmployeeProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
            case .success(let token):
                getProfileEmployeeUseCase.execute(token: token) { [self] result in
                    switch result {
                    case .success(let employeeUser):
                        print(employeeUser)
                        updateEmployeeProfileData(profileData: employeeUser)
                    case .failure(let error):
                        processError(error)
                    }
                }
            case .failure(let error):
                processError(error)
            }
        }
    }

    private func updateStudentUserProfileData(profileData: StudentUser) {
        sharedUserProfileData.userFIO =
            profileData.userInfo.name + " " + profileData.userInfo.surname + " " + profileData.userInfo.patronymic
        sharedUserProfileData.emailText = profileData.userInfo.email
        sharedUserProfileData.userRole =
            (RoleEnum.getValueFromString(profileData.userInfo.role)?.networkingValue)!
        sharedUserProfileData.acccountStatus = (AccountStatusEnum.getValueFromString(profileData.userInfo.accountStatus)?.networkingValue)!
        sharedUserProfileData.genderType = GenderProfileEnum.getValueFromString(profileData.userInfo.sex)!.rawValue
        sharedStudentProfileData.groupNumber = String(profileData.group.number!)
        sharedStudentProfileData.studentNumber = profileData.studentNumber
    }

    func logout() {
        logoutUseCase.execute(token: "")
    }

    private func updateExternalUserProfileData(profileData: User) {
        sharedUserProfileData.userFIO =
            profileData.name + " " + profileData.surname + " " + profileData.patronymic
        sharedUserProfileData.emailText = profileData.email
        sharedUserProfileData.userRole =
            (RoleEnum.getValueFromString(profileData.role)?.networkingValue)!
        sharedUserProfileData.acccountStatus = (AccountStatusEnum.getValueFromString(profileData.accountStatus)?.networkingValue)!
        sharedUserProfileData.genderType = GenderProfileEnum.getValueFromString(profileData.sex)!.rawValue
    }

    private func updateEmployeeProfileData(profileData: EmployeeUser) {
        sharedUserProfileData.userFIO =
            profileData.userInfo.name + " " + profileData.userInfo.surname + " " + profileData.userInfo.patronymic
        sharedUserProfileData.emailText = profileData.userInfo.email
        sharedUserProfileData.userRole =
            (RoleEnum.getValueFromString(profileData.userInfo.role)?.networkingValue)!
        sharedUserProfileData.acccountStatus = (AccountStatusEnum.getValueFromString(profileData.userInfo.accountStatus)?.networkingValue)!
        sharedUserProfileData.genderType = GenderProfileEnum.getValueFromString(profileData.userInfo.sex)!.rawValue
        sharedEmployeeProfileData.contractNumber = profileData.contractNumber
    }
}
