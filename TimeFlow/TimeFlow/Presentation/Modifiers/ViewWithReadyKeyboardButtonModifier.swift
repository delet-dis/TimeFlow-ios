//
//  ViewWithReadyKeyboardButtonModifier.swift
//  TimeFlow
//
//  Created by Igor Efimov on 26.02.2023.
//

import SwiftUI

struct ViewWithReadyKeyboardButtonModifier<T: Hashable>: ViewModifier {
    var focus: FocusState<T?>.Binding

    func body(content: Content) -> some View {
        return content
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if focus.wrappedValue != nil {
                        HStack {
                            Button(R.string.localizable.ready()) {
                                withAnimation {
                                    focus.wrappedValue = nil
                                }
                            }
                            .foregroundColor(
                                Color(R.color.lightYellow() ?? .yellow)
                            )

                            Spacer()
                        }
                    }
                }
            }
    }
}
