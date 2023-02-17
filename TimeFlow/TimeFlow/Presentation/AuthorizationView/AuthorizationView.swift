//
//  AuthorizationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct AuthorizationView: View {
    private enum Field: Hashable {
        case email, password
    }

    @EnvironmentObject private var viewModel: AuthorizationViewModel

    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField(R.string.localizable.email(), text: $viewModel.emailText)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }
                    .modifier(ViewWithRoundedGradientBackground())
                    .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
                    .foregroundColor(
                        Color(R.color.blueCustom() ?? .blue)
                    )
                    // TODO: move into the view modifier
                    .shadow(
                        color: Color.black.opacity(0.9),
                        radius: 8,
                        x: 2,
                        y: 2
                    )

                SecureField(R.string.localizable.password(), text: $viewModel.passwordText)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .password)
                    // TODO: move into the view modifier
                    .modifier(ViewWithRoundedGradientBackground())
                    .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))
                    .foregroundColor(
                        Color(R.color.blueCustom() ?? .blue)
                    )
                    .shadow(
                        color: Color.black.opacity(0.9),
                        radius: 8,
                        x: 2,
                        y: 2
                    )
            }

            VStack(spacing: 15) {
                // TODO: Добавить проверку на валидность полей и отобразить кнопку в другом состоянии
                Spacer()

                Button {
                    focusedField = nil

                    viewModel.login()
                } label: {
                    Text(R.string.localizable.login())
                        .font(
                            Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium))
                        )
                        .foregroundColor(
                            Color(R.color.blueCustom() ?? .blue)
                        )
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .modifier(ViewWithRoundedGradientBackground())
                }
                .shadow(
                    color: Color.black.opacity(0.9),
                    radius: 8,
                    x: 2,
                    y: 2
                )

                Button {
                    viewModel.setRegisrationViewClousure?()
                } label: {
                    Text(R.string.localizable.register())
                        .font(
                            Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium))
                        )
                        .foregroundColor(
                            Color(R.color.blueCustom() ?? .blue)
                        )
                }
                .padding(.horizontal, 10)
            }
            .ignoresSafeArea(.keyboard)
        }
        .background(
            yellowPurpleGradient
                .rotationEffect(.degrees(180))
                .ignoresSafeArea()
        )
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button(R.string.localizable.ready()) {
                        focusedField = nil
                    }
                    .foregroundColor(
                        Color(R.color.blueCustom() ?? .blue)
                    )

                    Spacer()
                }
            }
        }
        // Добавить Алерт
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        AuthorizationView()
            .environmentObject(mainComponent.authorizationComponent.authorizationViewModel)
    }
}
