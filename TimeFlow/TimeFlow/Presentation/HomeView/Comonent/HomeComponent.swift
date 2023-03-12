//
//  HomeComponent.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol HomeComponentDependency: Dependency {
    var getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase { get }
    var saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase { get }
    var getUserRoleUseCase: GetUserRoleUseCase { get }
    var getProfileStudentUseCase: GetProfileStudentUseCase { get }
    var getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
    var profileComponent: ProfileComponent { get }
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(
                getDisplayingScheduleUseCase: dependency.getDisplayingScheduleUseCase,
                saveDisplayingScheduleUseCase: dependency.saveDisplayingScheduleUseCase,
                getUserRoleUseCase: dependency.getUserRoleUseCase,
                getProfileStudentUseCase: dependency.getProfileStudentUseCase,
                getProfileEmployeeUseCase: dependency.getProfileEmployeeUseCase,
                getTokensUseCase: dependency.getTokensUseCase,
                profileComponent: dependency.profileComponent
            )
        }
    }

    var homeView: some View {
        shared {
            HomeView(viewModel: homeViewModel)
        }
    }
}
