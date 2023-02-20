//
//  RegistrationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var viewModel: RegistrationViewModel
    @State private var motionManager = MotionManager()
    @State private var isTopTextDisplaying = true

    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: StudentRegistrationView(), label: {
                Button {
                    viewModel.setStudentRegistrationViewClousure?()
                } label: {
                    Text(R.string.localizable.student())
                        .font(
                            Font(
                                R.font.ralewayBold(size: 15) ??
                                    .systemFont(ofSize: 15, weight: .medium)
                            )
                        )
                        .foregroundColor(.white)
                }
                .padding()
                .cornerRadius(16)
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 90)
                        .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
                }
            })

            Button {
                viewModel.setTeacherRegistrationViewClousure?()
            } label: {
                Text(R.string.localizable.teacher())
                    .font(
                        Font(
                            R.font.ralewayBold(size: 15) ??
                                .systemFont(ofSize: 15, weight: .medium)
                        )
                    )
                    .foregroundColor(.white)
            }
            .padding()
            .cornerRadius(16)
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 90)
                    .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            }
            Button {} label: {
                Text(R.string.localizable.externalUser())
                    .font(
                        Font(
                            R.font.ralewayBold(size: 15) ??
                                .systemFont(ofSize: 15, weight: .medium)
                        )
                    )
                    .foregroundColor(.white)
            }
            .padding()
            .cornerRadius(16)
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 90)
                    .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            }
        }
        .overlay {
            VStack(spacing: 15) {
                HStack {
                    Text(R.string.localizable.chooseTypeOfUser())
                        .font(
                            Font(R.font.ralewayBold(size: 25) ?? .systemFont(ofSize: 25, weight: .medium))
                        )

                    Spacer()
                }
            }
            .opacity(isTopTextDisplaying ? 1 : 0)
            .padding(.bottom, 450)
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
        .padding(.horizontal, 20)
    }
}

struct RegistrationView_Preview: PreviewProvider {
    private static let registrationComponent = RegistrationComponent()

    static var previews: some View {
        RegistrationView()
            .environmentObject(registrationComponent.registrationViewModel)
    }
}
