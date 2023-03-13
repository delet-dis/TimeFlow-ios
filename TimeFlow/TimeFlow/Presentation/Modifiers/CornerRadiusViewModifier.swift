//
//  CornerRadiusViewModifier.swift
//  TimeFlow
//
//  Created by Igor Efimov on 11.03.2023.
//

import Foundation
import SwiftUI

struct CornerRadiusViewModifier: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
