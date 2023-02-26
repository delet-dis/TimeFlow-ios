//
//  ElevatedViewModifier.swift
//  TimeFlow
//
//  Created by Igor Efimov on 23.02.2023.
//

import SwiftUI

struct ElevatedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .background {
                RoundedRectangle(cornerRadius: 90)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
    }
}
