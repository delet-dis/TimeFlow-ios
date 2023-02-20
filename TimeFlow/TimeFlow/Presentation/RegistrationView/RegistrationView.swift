//
//  RegistrationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import AxisSegmentedView
import Foundation
import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(R.string.localizable.helloRegister())
                    .font(
                        Font(R.font.ralewayBold(size: 30) ?? .systemFont(ofSize: 30, weight: .medium))
                    )

                Spacer()
            }

            AxisSegmentedView(selection: $viewModel.viewDisplayingModeIndex) {
                ForEach(RegistrationViewDisplayingModeEnum.allCases) { role in
                    Text(role.savedValue)
                        .itemTag(role.rawValue)
                }
            } style: {
                ASCapsuleStyle(
                    backgroundColor: .white,
                    foregroundColor: .init(uiColor: R.color.lightYellow() ?? .yellow),
                    movementMode: .viscosity
                )
            }

//            NavigationLink(destination: StudentRegistrationView(), label: {
//                Button {
//                    viewModel.setStudentRegistrationViewClousure?()
//                } label: {
//                    Text(R.string.localizable.student())
//                        .font(
//                            Font(
//                                R.font.ralewayBold(size: 15) ??
//                                    .systemFont(ofSize: 15, weight: .medium)
//                            )
//                        )
//                        .foregroundColor(.white)
//                }
//                .padding()
//                .cornerRadius(16)
//                .frame(minWidth: 0,
//                       maxWidth: .infinity)
//                .background {
//                    RoundedRectangle(cornerRadius: 90)
//                        .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
//                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
//                }
//            })
//
//            Button {
//                viewModel.setTeacherRegistrationViewClousure?()
//            } label: {
//                Text(R.string.localizable.teacher())
//                    .font(
//                        Font(
//                            R.font.ralewayBold(size: 15) ??
//                                .systemFont(ofSize: 15, weight: .medium)
//                        )
//                    )
//                    .foregroundColor(.white)
//            }
//            .padding()
//            .cornerRadius(16)
//            .frame(minWidth: 0,
//                   maxWidth: .infinity)
//            .background {
//                RoundedRectangle(cornerRadius: 90)
//                    .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
//                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
//            }
//            Button {} label: {
//                Text(R.string.localizable.externalUser())
//                    .font(
//                        Font(
//                            R.font.ralewayBold(size: 15) ??
//                                .systemFont(ofSize: 15, weight: .medium)
//                        )
//                    )
//                    .foregroundColor(.white)
//            }
//            .padding()
//            .cornerRadius(16)
//            .frame(minWidth: 0,
//                   maxWidth: .infinity)
//            .background {
//                RoundedRectangle(cornerRadius: 90)
//                    .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
//                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
//            }
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
