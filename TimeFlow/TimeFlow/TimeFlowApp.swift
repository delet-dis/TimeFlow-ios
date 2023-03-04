//
//  TimeFlowApp.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import NeedleFoundation
import SwiftUI

@main
struct TimeFlowApp: App {
    private let mainComponent: MainComponent

    init() {
        registerProviderFactories()

        self.mainComponent = .init()
    }

    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                mainComponent.mainView
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
