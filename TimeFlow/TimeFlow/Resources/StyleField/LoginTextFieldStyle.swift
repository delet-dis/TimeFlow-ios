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
            .foregroundColor(.red)
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.primary
                )
            )
            .padding(.horizontal, 15)
    }
}
