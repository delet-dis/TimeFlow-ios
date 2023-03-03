//
//  MainWindowSizeHelper.swift
//  TimeFlow
//
//  Created by Igor Efimov on 20.02.2023.
//

import Foundation
import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
