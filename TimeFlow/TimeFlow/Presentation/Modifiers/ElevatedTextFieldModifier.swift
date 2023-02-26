//
//  ElevatedTextFieldModifier.swift
//  TimeFlow
//
//  Created by Igor Efimov on 18.02.2023.
//

import Foundation
import SwiftUI

struct ElevatedTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
            .tint(.black)
            .padding()
            .modifier(ElevatedViewModifier())
    }
}
