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
    var getRoleUserUseCase: GetRoleUserUseCase { get }
    var profileComponent: ProfileComponent { get }
}

final class ProfileComponent: Component<ProfileComponentDependency> {
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(
                getTokensUseCase: dependency.getTokensUseCase,
                getProfileExternalUseCase: dependency.getProfileExternalUseCase,
                getRoleUserUseCase: dependency.getRoleUserUseCase 
            )
        }
    }
    
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(profileComponent: dependency.profileComponent)
        }
    }

    var profileView: some View {
        shared {
            ProfileView(viewModel: profileViewModel)
        }
    }
}
