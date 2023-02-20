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
    var studentRegistrationViewModel: StudentRegistrationViewModel {
        shared {
            StudentRegistrationViewModel()
        }
    }

    var studentRegistrationView: some View {
        shared {
            StudentRegistrationView()
                .environmentObject(studentRegistrationViewModel)
        }
    }

    var teacherRegistrationViewModel: TeacherRegistrationViewModel {
        shared {
            TeacherRegistrationViewModel()
        }
    }

    var teacherRegistrationView: some View {
        shared {
            TeacherRegistrationView()
                .environmentObject(teacherRegistrationViewModel)
        }
    }

    var externalUserRegistrationViewModel: ExternalUserRegistrationViewModel {
        shared {
            ExternalUserRegistrationViewModel()
        }
    }

    var externalUserRegistrationView: some View {
        shared {
            ExternalUserRegistrationView()
                .environmentObject(externalUserRegistrationViewModel)
        }
    }

    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel()
        }
    }

    var registrationView: some View {
        shared {
            RegistrationView()
                .environmentObject(registrationViewModel)
        }
    }
}
