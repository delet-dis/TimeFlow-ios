//
//  RegistrationComponent.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol RegistrationComponentDependency: Dependency {}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel()
        }
    }

    var registrationView: some View {
        shared {
            RegistrationView(viewModel: self.registrationViewModel)
        }
    }
}
