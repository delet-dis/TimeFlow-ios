//
//  ElevatedTextField.swift
//  TimeFlow
//
//  Created by Igor Efimov on 18.02.2023.
//

import Foundation
import SwiftUI

struct ElevatedTextField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
            .tint(.black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 90)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            }
    }
}
