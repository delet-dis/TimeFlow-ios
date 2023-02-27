//
//  LoginView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import SwiftUI

struct LoginView: View {
    @State private(set) var viewDisplayingMode = LoginViewDisplayingModeEnum.authorization
    @State private var motionManager = MotionManager()
    @State private var isLogoTopLocated = true

    @StateObject var viewModel: LoginViewModel

    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.mainWindowSize) var mainWindowSize

    var body: some View {
        ZStack {
            Group {
                switch viewDisplayingMode {
                case .registration:
                    viewModel.registrationComponent?.registrationView
                case .authorization:
                    viewModel.authorizationComponent?.authorizationView
                        .padding(.horizontal, 24)
                }
            }

            VStack {
                Spacer()
                
                HStack(spacing: 3) {
                    Group {
                        switch viewDisplayingMode {
                        case .authorization:
                            Text(R.string.localizable.dontHaveAnAccount())
                        case .registration:
                            Text(R.string.localizable.alreadyHaveAnAccount())
                        }
                    }
                    .font(
                        Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium))
                    )

                    Button {
                        viewModel.changeDisplayingMode()
                    } label: {
                        Group {
                            switch viewDisplayingMode {
                            case .authorization:
                                Text(R.string.localizable.register())
                            case .registration:
                                Text(R.string.localizable.signIn())
                            }
                        }
                        .font(
                            Font(
                                R.font.ralewayBold(size: 15) ??
                                    .systemFont(ofSize: 15, weight: .medium)
                            )
                        )
                        .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 90)
                        .foregroundColor(.white)
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
                        .rotationEffect(isLogoTopLocated ? .degrees(-30) : .degrees(-250))
                        .offset(
                            x: isLogoTopLocated ? 0 : -mainWindowSize.width / 2,
                            y: isLogoTopLocated ? 0 : mainWindowSize.height / 1.5
                        )
                }

                Spacer()
            }
            .ignoresSafeArea()
            .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 30))
        )
        .onChange(of: viewModel.viewDisplayingMode) { newValue in
            withAnimation {
                viewDisplayingMode = newValue
            }

            withAnimation(.easeOut(duration: 0.8)) {
                switch viewDisplayingMode {
                case .authorization:
                    isLogoTopLocated = true
                case .registration:
                    isLogoTopLocated = false
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        LoginView(viewModel: mainComponent.loginComponent.loginViewModel)
    }
}
