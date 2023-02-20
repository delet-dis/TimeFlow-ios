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

    var authRepository: AuthRepository {
        shared {
            AuthRepositoryImpl(jsonDecoder: jsonDecoder, jsonEncoder: jsonEncoder)
        }
    }

    var loginUseCase: LoginUseCase {
        shared {
            LoginUseCase(authRepository: authRepository)
        }
    }

    var logoutUseCase: LogoutUseCase {
        shared {
            LogoutUseCase(authRepository: authRepository)
        }
    }

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

    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                loginComponent: loginComponent
            )
        }
    }

    var mainView: some View {
        shared {
            MainView()
                .environmentObject(mainViewModel)
        }
    }
}
