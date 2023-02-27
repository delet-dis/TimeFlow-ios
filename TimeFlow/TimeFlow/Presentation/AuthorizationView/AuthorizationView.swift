//
//  AuthorizationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SPAlert
import SwiftUI

struct AuthorizationView: View, KeyboardReadable {
    private enum Field: Hashable {
        case email, password
    }

    @ObservedObject var viewModel: AuthorizationViewModel
    @State private var areFieldsValid = false

    @FocusState private var focusedField: Field?

    @State private var isTopTextDisplaying = true

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Group {
                    TextField(R.string.localizable.email(), text: $viewModel.emailText)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .onSubmit {
                            DispatchQueue.runAsyncOnMainWithDelay {
                                focusedField = .password
                            }
                        }

                    CustomSecureTextField(
                        R.string.localizable.password(),
                        text: $viewModel.passwordText
                    )
                    .submitLabel(.done)
                    .focused($focusedField, equals: .password)
                }
                .modifier(ElevatedTextFieldModifier())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            }
            .overlay {
                VStack(spacing: 15) {
                    HStack {
                        Text(R.string.localizable.hello())
                            .font(
                                Font(R.font.ralewayBold(size: 50) ?? .systemFont(ofSize: 50, weight: .medium))
                            )

                        Spacer()
                    }

                    HStack {
                        Text(R.string.localizable.pleaseLogin())
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(
                                Font(
                                    R.font.ralewayMedium(size: 20) ??
                                        .systemFont(ofSize: 20, weight: .medium)
                                )
                            )
                            .opacity(0.8)

                        Spacer()
                    }
                }
                .opacity(isTopTextDisplaying ? 1 : 0)
                .padding(.bottom, 450)
                .padding(.horizontal, 24)
                .onReceive(keyboardPublisher) { isKeyboardVisible in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isTopTextDisplaying = !isKeyboardVisible
                    }
                }
            }
            .overlay {
                HStack {
                    Spacer()

                    Button {
                        focusedField = nil

                        viewModel.login()
                    } label: {
                        HStack {
                            Text(R.string.localizable.login())
                                .font(
                                    Font(
                                        R.font.ralewayMedium(size: 15) ??
                                            .systemFont(ofSize: 15, weight: .medium)
                                    )
                                )

                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .padding(.horizontal, 20)
                    }
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                    }
                    .padding(.top, 5)
                    .shadow(color: Color(uiColor: R.color.lightYellow() ?? .yellow), radius: 20, x: 0, y: 0)
                }
                .padding(.top, 250)
            }
        }
        .modifier(ViewWithReadyKeyboardButtonModifier(focus: $focusedField))
        .SPAlert(
            isPresent: $viewModel.isAlertShowing,
            message: viewModel.alertText,
            dismissOnTap: false,
            preset: .error,
            haptic: .error
        )
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        AuthorizationView(viewModel: mainComponent.authorizationComponent.authorizationViewModel)
    }
}
