//
//  MainView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import NeedleFoundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewModel

    @State private var displayMode = MainViewDisaplyingModeEnum.authorization
    @State private var isSplashDisplaying = true

    var body: some View {
        viewModel.loginComponent?.loginView
    }
}

struct MainView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        MainView()
            .environmentObject(mainComponent.mainViewModel)
    }
}
