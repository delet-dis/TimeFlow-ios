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
                    Text(R.string.localizable.helloRegister())
                        .font(
                            Font(R.font.ralewayBold(size: 45) ?? .systemFont(ofSize: 45, weight: .medium))
                        )
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()
                }
            }
            .opacity(isTopTextDisplaying ? 1 : 0)
            .padding(.bottom, 450)
        }
    }
}

struct RegistrationView_Preview: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        RegistrationView()
            .environmentObject(mainComponent.registrationComponent.registrationViewModel)
    }
}
