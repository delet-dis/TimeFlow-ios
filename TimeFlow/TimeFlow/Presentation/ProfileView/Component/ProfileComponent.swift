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
}

final class ProfileComponent: Component<ProfileComponentDependency> {
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(
                getTokensUseCase: dependency.getTokensUseCase,
                getProfileExternalUseCase: dependency.getProfileExternalUseCase, getProfileStudentUseCase: dependency.getProfileStudentUseCase,
                getUserRoleUseCase: dependency.getUserRoleUseCase,
                logoutUseCase: dependency.logoutUseCase
            )
        }
    }

    var profileView: some View {
        shared {
            ProfileView(viewModel: profileViewModel)
        }
    }
}
