//
//  RegistrationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import AxisSegmentedView
import Foundation
import SPAlert
import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel: RegistrationViewModel

    @State private var viewDisplayingMode = RegistrationViewDisplayingModeEnum.teacher

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(R.string.localizable.helloRegister())
                    .font(
                        Font(R.font.ralewayBold(size: 30) ?? .systemFont(ofSize: 30, weight: .medium))
                    )

                Spacer()
            }
            .padding(.horizontal, 24)

            VStack {
                AxisSegmentedView(selection: $viewModel.viewDisplayingModeIndex) {
                    ForEach(RegistrationViewDisplayingModeEnum.allCases) { role in
                        Text(role.savedValue)
                            .itemTag(role.rawValue)
                            .font(.system(size: 20))
                    }
                } style: {
                    ASCapsuleStyle(
                        backgroundColor: .white,
                        foregroundColor: .init(uiColor: R.color.lightYellow() ?? .yellow),
                        movementMode: .normal
                    )
                }
                .modifier(ElevatedViewModifier())
                .frame(height: 50)
            }
            .padding(.horizontal, 10)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    SharedRegistrationFormView(
                        viewData: $viewModel.sharedRegistrationData,
                        viewState: $viewModel.sharedRegistrationFieldsState
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 25)

                    Spacer()

                    switch viewDisplayingMode {
                    case .teacher:
                        TeacherRegistrationFormView(
                            viewData: $viewModel.sharedTeacherRegistrationData,
                            viewState: $viewModel.sharedTeacherRegistrationState
                        )
                    case .student:
                        StudentRegistrationFormView(
                            viewData: $viewModel.sharedStudentRegistrationData,
                            viewState: $viewModel.sharedStudentRegistrationState
                        )
                    case .externalUser:
                        EmptyView()
                    }

                    HStack {
                        Spacer()

                        Button {
                            viewModel.register()
                        } label: {
                            HStack {
                                Text(R.string.localizable.register())
                                    .font(
                                        Font(
                                            R.font.ralewayMedium(size: 15) ??
                                                .systemFont(ofSize: 15, weight: .medium)
                                        )
                                    )

                                Image(systemName: "person")
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
                        .shadow(
                            color: Color(uiColor: R.color.lightYellow() ?? .yellow),
                            radius: 20,
                            x: 0,
                            y: 0
                        )
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 80)
                    .padding(.horizontal, 24)
                }
            }
            .onChange(of: viewModel.viewDisplayingMode) { newValue in
                withAnimation {
                    viewDisplayingMode = newValue
                }
            }
        }
        .onDisappear{
            viewModel.viewDidDisappear()
        }
        .SPAlert(
            isPresent: $viewModel.isAlertShowing,
            message: viewModel.alertText,
            dismissOnTap: false,
            preset: .error,
            haptic: .error
        )
    }
}

struct RegistrationView_Preview: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        RegistrationView(viewModel: mainComponent.registrationComponent.registrationViewModel)
    }
}
