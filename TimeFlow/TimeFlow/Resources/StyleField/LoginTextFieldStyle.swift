//
//  LoginTextFieldStyle.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    LinearGradient(gradient: Gradient(colors:
                        [Color(UIColor(named:
                            "GradientYellow")
                            ?? .white),
                        Color(UIColor(named:
                            "GradientLightYellow")
                            ?? .white),
                        Color(UIColor(named:
                            "GradientPurple")
                            ?? .white)]),
                    startPoint: .bottomTrailing, endPoint: .topLeading)
                )
            )
            .padding(.horizontal, 15)
    }
}
