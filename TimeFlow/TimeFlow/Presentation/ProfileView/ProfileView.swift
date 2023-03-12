//
//  ProfileView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
//    @State private var userRole = RoleEnum.student

    var body: some View {
//
//        switch userRole {
//        case .user:
//            Text("Внешний пользователь")
//        case .employee:
//            Text("Сотрудник")
//        case .student:
//            Text("Студент")
//        }
        
        Text("Test")
            .onAppear {
                viewModel.viewDidAppear()
                print(viewModel.userRole)
                print("Roleee")
                print(RoleEnum.getValueByRequest(viewModel.userRole) as Any)
                viewModel.updateExternalUserProfileData()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        ProfileView(viewModel: mainComponent.profileComponent.profileViewModel)
    }
}
