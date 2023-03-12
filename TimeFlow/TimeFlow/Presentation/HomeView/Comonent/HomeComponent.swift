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
    var profileComponent: ProfileComponent { get }
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(
                getDisplayingScheduleUseCase: dependency.getDisplayingScheduleUseCase,
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
