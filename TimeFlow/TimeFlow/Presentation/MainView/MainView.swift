//
//  MainView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import SPAlert
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    @State private var displayingMode = MainViewDisaplyingModeEnum.authorization
    @State private var isSplashDisplaying = true

    var body: some View {
        ZStack {
            switch displayingMode {
            case .authorization:
                viewModel.loginComponent?.loginView
            case .homeScreen:
                viewModel.homeComponent?.homeView
            }

            SplashView()
                .opacity(isSplashDisplaying ? 1 : 0)
        }
        .onReceive(viewModel.$mainViewDispalyingMode) { value in
            withAnimation {
                self.displayingMode = value
            }
        }
        .onReceive(viewModel.$isSplashDisplaying) { value in
            withAnimation {
                self.isSplashDisplaying = value
            }
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
        .SPAlert(
            isPresent: $viewModel.isAlertShowing,
            message: viewModel.alertText,
            dismissOnTap: false,
            preset: .error,
            haptic: .error
        )
    }
}

struct MainView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        MainView(viewModel: mainComponent.mainViewModel)
    }
}
