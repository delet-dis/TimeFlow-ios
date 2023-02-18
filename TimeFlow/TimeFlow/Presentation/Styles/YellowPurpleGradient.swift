//
//  YellowPurpleGradient.swift
//  TimeFlow
//
//  Created by Igor Efimov on 18.02.2023.
//

import Foundation
import SwiftUI

var yellowPurpleGradient: LinearGradient {
    LinearGradient(gradient:
        Gradient(
            colors:
            [Color(R.color.gradientYellow() ?? .white),
             Color(R.color.lightYellow() ?? .white),
             Color(R.color.gradientPurple() ?? .white)]),
        startPoint: .bottomTrailing,
        endPoint: .topLeading)
}
