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
        ZStack {}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
