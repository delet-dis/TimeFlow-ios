//
//  RegistrationComponent.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol RegistrationComponentDependency: Dependency {
    var registrationUseCase: RegisterUseCase { get }
}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel(registerUseCase: dependency.registrationUseCase)
        }
    }

    var registrationView: some View {
        shared {
            RegistrationView(viewModel: self.registrationViewModel)
        }
    }
}
