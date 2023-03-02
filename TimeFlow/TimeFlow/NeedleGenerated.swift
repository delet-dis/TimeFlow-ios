

import Foundation
import NeedleFoundation
import SwiftUI

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class RegistrationComponentDependency45ce06ac0365c929bb6bProvider: RegistrationComponentDependency {
    var registerStudentUseCase: RegisterStudentUseCase {
        return mainComponent.registerStudentUseCase
    }
    var registerTeacherUseCase: RegisterTeacherUseCase {
        return mainComponent.registerTeacherUseCase
    }
    var registerExternalUserUseCase: RegisterExternalUserUseCase {
        return mainComponent.registerExternalUserUseCase
    }
    var groupStudentUseCase: GroupStudentUseCase {
        return mainComponent.groupStudentUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->RegistrationComponent
private func factorybf509de48c6e5261a8800ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegistrationComponentDependency45ce06ac0365c929bb6bProvider(mainComponent: parent1(component) as! MainComponent)
}
private class AuthorizationComponentDependency01c300e9208281b9a593Provider: AuthorizationComponentDependency {
    var loginUseCase: LoginUseCase {
        return mainComponent.loginUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AuthorizationComponent
private func factory36d2db3a6303047193540ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationComponentDependency01c300e9208281b9a593Provider(mainComponent: parent1(component) as! MainComponent)
}
private class LoginComponentDependency09f1bea0f04d764af082Provider: LoginComponentDependency {
    var authorizationComponent: AuthorizationComponent {
        return mainComponent.authorizationComponent
    }
    var registrationComponent: RegistrationComponent {
        return mainComponent.registrationComponent
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->LoginComponent
private func factory7d788d11c001389505f70ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return LoginComponentDependency09f1bea0f04d764af082Provider(mainComponent: parent1(component) as! MainComponent)
}

#else
extension RegistrationComponent: Registration {
    public func registerItems() {
        keyPathToName[\RegistrationComponentDependency.registerStudentUseCase] = "registerStudentUseCase-RegisterStudentUseCase"
        keyPathToName[\RegistrationComponentDependency.registerTeacherUseCase] = "registerTeacherUseCase-RegisterTeacherUseCase"
        keyPathToName[\RegistrationComponentDependency.registerExternalUserUseCase] = "registerExternalUserUseCase-RegisterExternalUserUseCase"
        keyPathToName[\RegistrationComponentDependency.groupStudentUseCase] = "groupStudentUseCase-GroupStudentUseCase"
    }
}
extension AuthorizationComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthorizationComponentDependency.loginUseCase] = "loginUseCase-LoginUseCase"
    }
}
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension LoginComponent: Registration {
    public func registerItems() {
        keyPathToName[\LoginComponentDependency.authorizationComponent] = "authorizationComponent-AuthorizationComponent"
        keyPathToName[\LoginComponentDependency.registrationComponent] = "registrationComponent-RegistrationComponent"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->MainComponent->RegistrationComponent", factorybf509de48c6e5261a8800ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthorizationComponent", factory36d2db3a6303047193540ae93e637f014511a119)
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->LoginComponent", factory7d788d11c001389505f70ae93e637f014511a119)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
