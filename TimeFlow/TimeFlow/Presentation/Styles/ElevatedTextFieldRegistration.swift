//
//  ElevatedTextFieldRegistration.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Foundation
import SwiftUI

struct ElevatedTextFieldRegistration: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
            .tint(.black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            }
    }
}
