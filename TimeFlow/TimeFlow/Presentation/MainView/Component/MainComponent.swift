//
//  MainComponent.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

class MainComponent: BootstrapComponent {
    var jsonDecoder: JSONDecoder {
        shared {
            let decoder = JSONDecoder()
            //            decoder.dateDecodingStrategy = .iso8601

            return decoder
        }
    }

    var jsonEncoder: JSONEncoder {
        shared {
            let encoder = JSONEncoder()
            //            encoder.dateEncodingStrategy = .iso8601

            return encoder
        }
    }

    // MARK: Repositories

    var authRepository: AuthRepository {
        shared {
            AuthRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }
    
    var studentsGroupRepository: StudentsGroupRepository{
        shared{
            StudentsGroupRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }

    var registrationRepository: RegistrationRepository {
        shared {
            RegistrationRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }

    // MARK: Auth use cases

    var loginUseCase: LoginUseCase {
        shared {
            LoginUseCase(authRepository: authRepository)
        }
    }

    // MARK: Register use cases

    var registerStudentUseCase: RegisterStudentUseCase {
        shared {
            RegisterStudentUseCase(registrationRepository: registrationRepository)
        }
    }
    
    var groupStudentUseCase: GroupStudentUseCase{
        shared{
            GroupStudentUseCase(studentGroupRepository: studentsGroupRepository)
        }
    }

    var registerTeacherUseCase: RegisterTeacherUseCase {
        shared {
            RegisterTeacherUseCase(registrationRepository: registrationRepository)
        }
    }

    var registerExternalUserUseCase: RegisterExternalUserUseCase {
        shared {
            RegisterExternalUserUseCase(registrationRepository: registrationRepository)
        }
    }

    var logoutUseCase: LogoutUseCase {
        shared {
            LogoutUseCase(authRepository: authRepository)
        }
    }

    // MARK: Components

    var authorizationComponent: AuthorizationComponent {
        shared {
            AuthorizationComponent(parent: self)
        }
    }

    var registrationComponent: RegistrationComponent {
        shared {
            RegistrationComponent(parent: self)
        }
    }

    var loginComponent: LoginComponent {
        shared {
            LoginComponent(parent: self)
        }
    }

    // MARK: Main
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                loginComponent: loginComponent
            )
        }
    }

    var mainView: some View {
        shared {
            MainView(viewModel: self.mainViewModel)
        }
    }
}
