//
//  AuthorizationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct AuthorizationView: View, KeyboardReadable {
    private enum Field: Hashable {
        case email, password
    }

    @EnvironmentObject private var viewModel: AuthorizationViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    @FocusState private var focusedField: Field?

    @State private var motionManager = MotionManager()

    @State private var isTopTextDisplaying = true

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField(R.string.localizable.email(), text: $viewModel.emailText)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        DispatchQueue.runAsyncOnMainWithDelay {
                            focusedField = .password
                        }
                    }
                    .modifier(ElevatedTextField())

//                SecureField(R.string.localizable.password(), text: $viewModel.passwordText)
                CustomSecureTextField(R.string.localizable.password(), text: $viewModel.passwordText)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .password)
                    .modifier(ElevatedTextField())
            }
            .padding(.horizontal, 24)
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
                .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 10))
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
                .padding(.horizontal, 24)
            }

            VStack(spacing: 15) {
                // TODO: Добавить проверку на валидность полей и отобразить кнопку в другом состоянии
                Spacer()

                HStack(spacing: 3) {
                    Text(R.string.localizable.dontHaveAnAccount())
                        .font(
                            Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium))
                        )

                    Button {
                        viewModel.setRegisrationViewClousure?()
                    } label: {
                        Text(R.string.localizable.register())
                            .font(
                                Font(
                                    R.font.ralewayBold(size: 15) ??
                                        .systemFont(ofSize: 15, weight: .medium)
                                )
                            )
                            .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .padding(.bottom, safeAreaInsets.bottom > 0 ? 0 : 10)
        }
        .background(
            VStack {
                HStack {
                    Spacer()

                    Image(uiImage: R.image.appIconCopy() ?? .strokedCheckmark)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(30)
                        .blur(radius: 6)
                        .rotationEffect(.degrees(-30))
                }

                Spacer()
            }
            .ignoresSafeArea()
            .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 30))
        )
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button(R.string.localizable.ready()) {
                        focusedField = nil
                    }
                    .foregroundColor(
                        Color(R.color.lightYellow() ?? .yellow)
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
