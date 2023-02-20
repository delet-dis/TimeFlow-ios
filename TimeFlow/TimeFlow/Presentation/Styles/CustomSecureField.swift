//
//  CustomSecureField.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 18.02.2023.
//

import Foundation
import SwiftUI

struct CustomSecureTextField: View, KeyboardReadable {
    @Binding private var text: String
    @State private var isSecured: Bool = true

    @State private var isVisibilityToggleDisplaying = true

    private var title: String

    init(
        _ title: String,
        text: Binding<String>
    ) {
        self.title = title
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .padding(.trailing, 32)
            .frame(height: 20)

            Button {
                isSecured.toggle()
            } label: {
                Image(systemName: isSecured ? "eyes" : "eyes.inverse")
                    .accentColor(.gray)
                    .foregroundColor(Color(uiColor: R.color.nightBeigeColor() ?? .yellow))
            }
            .opacity(isVisibilityToggleDisplaying ? 1 : 0)
            .onReceive(keyboardPublisher) { isKeyboardVisible in
                withAnimation {
                    isVisibilityToggleDisplaying = !isKeyboardVisible
                }
            }
        }
    }
}
