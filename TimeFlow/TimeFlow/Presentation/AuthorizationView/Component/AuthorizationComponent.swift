//
//  AuthorizationComponent.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol AuthorizationComponentDependency: Dependency {
    var loginUseCase: LoginUseCase { get }
}

final class AuthorizationComponent: Component<AuthorizationComponentDependency> {
    var authorizationViewModel: AuthorizationViewModel {
        shared {
            AuthorizationViewModel(
                loginUseCase: dependency.loginUseCase)
        }
    }

    var authorizationView: some View {
        shared {
            AuthorizationView()
                .environmentObject(authorizationViewModel)
        }
    }
}
