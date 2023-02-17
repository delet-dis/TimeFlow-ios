//
//  ViewWithRoundedGradientBackground.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct ViewWithRoundedGradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .padding()
            .cornerRadius(16)
            .background(
                RoundedRectangle(
                    cornerRadius: 16
                )
                .stroke(
                    yellowPurpleGradient
                )
            )
            .padding(.horizontal, 15)
    }
}
