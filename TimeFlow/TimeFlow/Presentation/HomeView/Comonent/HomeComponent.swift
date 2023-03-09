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
    var getTokenUseCase: GetTokenUseCase {get}
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(getTokenUseCase: dependency.getTokenUseCase)
        }
    }

    var homeView: some View {
        shared {
            HomeView(viewModel: homeViewModel)
        }
    }
}
