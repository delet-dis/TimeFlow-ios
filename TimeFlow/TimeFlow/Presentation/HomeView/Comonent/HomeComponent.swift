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
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel()
        }
    }

    var homeView: some View {
        shared {
            HomeView(viewModel: homeViewModel)
        }
    }
}
