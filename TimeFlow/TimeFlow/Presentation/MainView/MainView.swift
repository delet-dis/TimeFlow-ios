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

    init() {
        registerProviderFactories()
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
