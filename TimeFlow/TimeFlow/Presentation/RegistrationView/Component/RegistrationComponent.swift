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
    var registerStudentUseCase: RegisterStudentUseCase { get }
    var registerTeacherUseCase: RegisterTeacherUseCase { get }
    var registerExternalUserUseCase: RegisterExternalUserUseCase { get }
    var groupStudentUseCase: GroupStudentUseCase { get }
}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel(
                registerStudentUseCase: dependency.registerStudentUseCase,
                registerTeacherUseCase: dependency.registerTeacherUseCase,
                registerExternalUserUseCase: dependency.registerExternalUserUseCase, getStudentGroupUseCase: dependency.groupStudentUseCase
            )
        }
    }

    var registrationView: some View {
        shared {
            RegistrationView(viewModel: self.registrationViewModel)
        }
    }
}
