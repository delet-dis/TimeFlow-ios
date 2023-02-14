//
//  MainComponent.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import Foundation
import NeedleFoundation
import SwiftUI

class MainComponent: BootstrapComponent {
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel()
        }
    }

    var mainView: some View {
        shared {
            MainView()
                .environmentObject(mainViewModel)
        }
    }
}
