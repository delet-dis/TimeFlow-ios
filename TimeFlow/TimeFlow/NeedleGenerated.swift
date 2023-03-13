

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
    var getStudentGroupsUseCase: GetStudentGroupsUseCase {
        return mainComponent.getStudentGroupsUseCase
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
private class ProfileComponentDependency919001f509df49c9c523Provider: ProfileComponentDependency {
    var getTokensUseCase: GetTokensUseCase {
        return mainComponent.getTokensUseCase
    }
    var getProfileExternalUseCase: GetProfileExternalUseCase {
        return mainComponent.getProfileExternalUseCase
    }
    var getProfileStudentUseCase: GetProfileStudentUseCase {
        return mainComponent.getProfileStudentUseCase
    }
    var getUserRoleUseCase: GetUserRoleUseCase {
        return mainComponent.getUserRoleUseCase
    }
    var logoutUseCase: LogoutUseCase {
        return mainComponent.logoutUseCase
    }
    var getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase {
        return mainComponent.getProfileEmployeeUseCase
    }
    var getTeachersListUseCase: GetTeachersListUseCase {
        return mainComponent.getTeachersListUseCase
    }
    var getClassroomsListUseCase: GetClassroomsListUseCase {
        return mainComponent.getClassroomsListUseCase
    }
    var getStudentGroupsUseCase: GetStudentGroupsUseCase {
        return mainComponent.getStudentGroupsUseCase
    }
    var saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase {
        return mainComponent.saveDisplayingScheduleUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ProfileComponent
private func factory85f38151f9d92062292c0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProfileComponentDependency919001f509df49c9c523Provider(mainComponent: parent1(component) as! MainComponent)
}
private class HomeComponentDependency887e91671f4424758155Provider: HomeComponentDependency {
    var getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase {
        return mainComponent.getDisplayingScheduleUseCase
    }
    var saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase {
        return mainComponent.saveDisplayingScheduleUseCase
    }
    var getUserRoleUseCase: GetUserRoleUseCase {
        return mainComponent.getUserRoleUseCase
    }
    var getProfileStudentUseCase: GetProfileStudentUseCase {
        return mainComponent.getProfileStudentUseCase
    }
    var getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase {
        return mainComponent.getProfileEmployeeUseCase
    }
    var getTokensUseCase: GetTokensUseCase {
        return mainComponent.getTokensUseCase
    }
    var getTeacherLessonsUseCase: GetTeacherLessonsUseCase {
        return mainComponent.getTeacherLessonsUseCase
    }
    var getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase {
        return mainComponent.getStudentGroupLessonsUseCase
    }
    var getClassroomLessonsUseCase: GetClassroomLessonsUseCase {
        return mainComponent.getClassroomLessonsUseCase
    }
    var profileComponent: ProfileComponent {
        return mainComponent.profileComponent
    }
    var getTeachersListUseCase: GetTeachersListUseCase {
        return mainComponent.getTeachersListUseCase
    }
    var getClassroomsListUseCase: GetClassroomsListUseCase {
        return mainComponent.getClassroomsListUseCase
    }
    var getStudentGroupsUseCase: GetStudentGroupsUseCase {
        return mainComponent.getStudentGroupsUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->HomeComponent
private func factory9bc7b43729f663f093120ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeComponentDependency887e91671f4424758155Provider(mainComponent: parent1(component) as! MainComponent)
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
        keyPathToName[\RegistrationComponentDependency.getStudentGroupsUseCase] = "getStudentGroupsUseCase-GetStudentGroupsUseCase"
    }
}
extension AuthorizationComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthorizationComponentDependency.loginUseCase] = "loginUseCase-LoginUseCase"
    }
}
extension ProfileComponent: Registration {
    public func registerItems() {
        keyPathToName[\ProfileComponentDependency.getTokensUseCase] = "getTokensUseCase-GetTokensUseCase"
        keyPathToName[\ProfileComponentDependency.getProfileExternalUseCase] = "getProfileExternalUseCase-GetProfileExternalUseCase"
        keyPathToName[\ProfileComponentDependency.getProfileStudentUseCase] = "getProfileStudentUseCase-GetProfileStudentUseCase"
        keyPathToName[\ProfileComponentDependency.getUserRoleUseCase] = "getUserRoleUseCase-GetUserRoleUseCase"
        keyPathToName[\ProfileComponentDependency.logoutUseCase] = "logoutUseCase-LogoutUseCase"
        keyPathToName[\ProfileComponentDependency.getProfileEmployeeUseCase] = "getProfileEmployeeUseCase-GetProfileEmployeeUseCaseCase"
        keyPathToName[\ProfileComponentDependency.getTeachersListUseCase] = "getTeachersListUseCase-GetTeachersListUseCase"
        keyPathToName[\ProfileComponentDependency.getClassroomsListUseCase] = "getClassroomsListUseCase-GetClassroomsListUseCase"
        keyPathToName[\ProfileComponentDependency.getStudentGroupsUseCase] = "getStudentGroupsUseCase-GetStudentGroupsUseCase"
        keyPathToName[\ProfileComponentDependency.saveDisplayingScheduleUseCase] = "saveDisplayingScheduleUseCase-SaveDisplayingScheduleUseCase"
    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeComponentDependency.getDisplayingScheduleUseCase] = "getDisplayingScheduleUseCase-GetDisplayingScheduleUseCase"
        keyPathToName[\HomeComponentDependency.saveDisplayingScheduleUseCase] = "saveDisplayingScheduleUseCase-SaveDisplayingScheduleUseCase"
        keyPathToName[\HomeComponentDependency.getUserRoleUseCase] = "getUserRoleUseCase-GetUserRoleUseCase"
        keyPathToName[\HomeComponentDependency.getProfileStudentUseCase] = "getProfileStudentUseCase-GetProfileStudentUseCase"
        keyPathToName[\HomeComponentDependency.getProfileEmployeeUseCase] = "getProfileEmployeeUseCase-GetProfileEmployeeUseCaseCase"
        keyPathToName[\HomeComponentDependency.getTokensUseCase] = "getTokensUseCase-GetTokensUseCase"
        keyPathToName[\HomeComponentDependency.getTeacherLessonsUseCase] = "getTeacherLessonsUseCase-GetTeacherLessonsUseCase"
        keyPathToName[\HomeComponentDependency.getStudentGroupLessonsUseCase] = "getStudentGroupLessonsUseCase-GetStudentGroupLessonsUseCase"
        keyPathToName[\HomeComponentDependency.getClassroomLessonsUseCase] = "getClassroomLessonsUseCase-GetClassroomLessonsUseCase"
        keyPathToName[\HomeComponentDependency.profileComponent] = "profileComponent-ProfileComponent"
        keyPathToName[\HomeComponentDependency.getTeachersListUseCase] = "getTeachersListUseCase-GetTeachersListUseCase"
        keyPathToName[\HomeComponentDependency.getClassroomsListUseCase] = "getClassroomsListUseCase-GetClassroomsListUseCase"
        keyPathToName[\HomeComponentDependency.getStudentGroupsUseCase] = "getStudentGroupsUseCase-GetStudentGroupsUseCase"
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
    registerProviderFactory("^->MainComponent->ProfileComponent", factory85f38151f9d92062292c0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->HomeComponent", factory9bc7b43729f663f093120ae93e637f014511a119)
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->LoginComponent", factory7d788d11c001389505f70ae93e637f014511a119)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
