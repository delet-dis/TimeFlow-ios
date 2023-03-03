//
//  LoginComponent.swift
//  TimeFlow
//
//  Created by Igor Efimov on 20.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol LoginComponentDependency: Dependency {
    var authorizationComponent: AuthorizationComponent { get }
    var registrationComponent: RegistrationComponent { get }
}

final class LoginComponent: Component<LoginComponentDependency> {
    var loginViewModel: LoginViewModel {
        shared {
            LoginViewModel(
                authorizationComponent: dependency.authorizationComponent,
                registrationComponent: dependency.registrationComponent
            )
        }
    }

    var loginView: some View {
        shared {
            LoginView(viewModel: self.loginViewModel)
        }
    }
}
