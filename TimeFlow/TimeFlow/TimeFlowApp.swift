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
    init() {
        registerProviderFactories()
    }

    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                MainComponent().mainView
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
