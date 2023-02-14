//
//  teeestApp.swift
//  teeest
//
//  Created by Семён Алимпиев on 14.02.2023.
//

import SwiftUI

@main
struct teeestApp: App {
    var body: some Scene {
        WindowGroup {
            LoginRegisterView(viewModel: .init(condition: .logIn))
        }
    }
}

