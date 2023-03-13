//
//  ProfileComponent.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol ProfileComponentDependency: Dependency {
    var getTokensUseCase: GetTokensUseCase { get }
    var getProfileExternalUseCase: GetProfileExternalUseCase { get }
    var getProfileStudentUseCase: GetProfileStudentUseCase { get }
    var getUserRoleUseCase: GetUserRoleUseCase { get }
    var logoutUseCase: LogoutUseCase { get }
    var getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase { get }
    var getTeachersListUseCase: GetTeachersListUseCase { get }
    var getClassroomsListUseCase: GetClassroomsListUseCase { get }
    var getStudentGroupsUseCase: GetStudentGroupsUseCase { get }
    var saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase { get }
}

final class ProfileComponent: Component<ProfileComponentDependency> {
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(
                getTokensUseCase: dependency.getTokensUseCase,
                getProfileExternalUseCase: dependency.getProfileExternalUseCase, getProfileStudentUseCase: dependency.getProfileStudentUseCase,
                getUserRoleUseCase: dependency.getUserRoleUseCase,
                logoutUseCase: dependency.logoutUseCase,
                getProfileEmployeeUseCase: dependency.getProfileEmployeeUseCase,
                getTeachersListUseCase: dependency.getTeachersListUseCase,
                getClassroomsListUseCase: dependency.getClassroomsListUseCase,
                getStudentGroupsUseCase: dependency.getStudentGroupsUseCase,
                saveDisplayingScheduleUseCase: dependency.saveDisplayingScheduleUseCase
            )
        }
    }

    var profileView: some View {
        shared {
            ProfileView(viewModel: profileViewModel)
        }
    }
}
