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

    var studentGroupsRepository: StudentGroupsRepository {
        shared {
            StudentGroupsRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }

    var registrationRepository: RegistrationRepository {
        shared {
            RegistrationRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }

    var keychainRepository: KeychainRepository {
        shared {
            KeychainRepositoryImpl()
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
            RegisterStudentUseCase(
                registrationRepository: registrationRepository,
                saveTokensUseCase: saveTokensUseCase,
                saveAuthStatusUseCase: saveAuthStatusUseCase
            )
        }
    }

    var getStudentGroupsUseCase: GetStudentGroupsUseCase {
        shared {
            GetStudentGroupsUseCase(studentGroupRepository: studentGroupsRepository)
        }
    }

    var registerTeacherUseCase: RegisterTeacherUseCase {
        shared {
            RegisterTeacherUseCase(
                registrationRepository: registrationRepository,
                saveTokensUseCase: saveTokensUseCase,
                saveAuthStatusUseCase: saveAuthStatusUseCase
            )
        }
    }

    var registerExternalUserUseCase: RegisterExternalUserUseCase {
        shared {
            RegisterExternalUserUseCase(
                registrationRepository: registrationRepository,
                saveTokensUseCase: saveTokensUseCase,
                saveAuthStatusUseCase: saveAuthStatusUseCase
            )
        }
    }

    var logoutUseCase: LogoutUseCase {
        shared {
            LogoutUseCase(authRepository: authRepository)
        }
    }

    // MARK: Keychain use cases

    var saveTokensUseCase: SaveTokensUseCase {
        shared {
            SaveTokensUseCase(keychainRepository: keychainRepository)
        }
    }

    // MARK: UserDefaults use cases

    var saveAuthStatusUseCase: SaveAuthStatusUseCase {
        shared {
            SaveAuthStatusUseCase()
        }
    }

    var getAuthStatusUseCase: GetAuthStatusUseCase {
        shared {
            GetAuthStatusUseCase()
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

    var homeComponent: HomeComponent {
        shared {
            HomeComponent(parent: self)
        }
    }

    // MARK: Main

    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                getAuthStatusUseCase: getAuthStatusUseCase,
                loginComponent: loginComponent,
                homeComponent: homeComponent
            )
        }
    }

    var mainView: some View {
        shared {
            MainView(viewModel: self.mainViewModel)
        }
    }
}
