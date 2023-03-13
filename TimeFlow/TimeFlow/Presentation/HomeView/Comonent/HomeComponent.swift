//
//  HomeComponent.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol HomeComponentDependency: Dependency {
    var getDisplayingScheduleUseCase: GetDisplayingScheduleUseCase { get }
    var saveDisplayingScheduleUseCase: SaveDisplayingScheduleUseCase { get }
    var getUserRoleUseCase: GetUserRoleUseCase { get }
    var getProfileStudentUseCase: GetProfileStudentUseCase { get }
    var getProfileEmployeeUseCase: GetProfileEmployeeUseCaseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }

    var getTeacherLessonsUseCase: GetTeacherLessonsUseCase { get }
    var getStudentGroupLessonsUseCase: GetStudentGroupLessonsUseCase { get }
    var getClassroomLessonsUseCase: GetClassroomLessonsUseCase { get }

    var profileComponent: ProfileComponent { get }
    
    var getTeachersListUseCase: GetTeachersListUseCase { get }
    var getClassroomsListUseCase: GetClassroomsListUseCase { get }
    var getStudentGroupsUseCase: GetStudentGroupsUseCase { get }
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(
                getDisplayingScheduleUseCase: dependency.getDisplayingScheduleUseCase,
                saveDisplayingScheduleUseCase: dependency.saveDisplayingScheduleUseCase,
                getUserRoleUseCase: dependency.getUserRoleUseCase,
                getProfileStudentUseCase: dependency.getProfileStudentUseCase,
                getProfileEmployeeUseCase: dependency.getProfileEmployeeUseCase,
                getTokensUseCase: dependency.getTokensUseCase,

                getTeachersListUseCase: dependency.getTeachersListUseCase,
                getClassroomsListUseCase: dependency.getClassroomsListUseCase,
                getStudentGroupsUseCase: dependency.getStudentGroupsUseCase,
                
                getTeacherLessonsUseCase: dependency.getTeacherLessonsUseCase,
                getStudentGroupLessonsUseCase: dependency.getStudentGroupLessonsUseCase,
                getClassroomLessonsUseCase: dependency.getClassroomLessonsUseCase,

                profileComponent: dependency.profileComponent
            )
        }
    }

    var homeView: some View {
        shared {
            HomeView(viewModel: homeViewModel)
        }
    }
}
