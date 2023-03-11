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
    var getProfileUseCase: GetProfileUseCase { get }
}

final class ProfileComponent: Component<ProfileComponentDependency> {
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(
                getTokensUseCase: dependency.getTokensUseCase,
                getProfileUseCase: dependency.getProfileUseCase
            )
        }
    }

    var profileView: some View {
        shared {
            ProfileView(viewModel: profileViewModel)
        }
    }
}
