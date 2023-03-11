//
//  ProfileView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {
        Text("Профиль")
            .onAppear{
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
