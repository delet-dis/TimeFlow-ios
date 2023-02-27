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

            ScrollView {
                VStack(spacing: 10) {
                    SharedRegistrationFormView(
                        viewData: $viewModel.sharedRegistrationData,
                        viewState: $viewModel.sharedRegistrationFieldsState,
                        lastTextFieldUnselectedClosure: {
                            //                            switch viewDisplayingMode {
                            //                            case .teacher:
                            //                                teacherRegistrationFormView?
                            //                                    .selectFirstField()
                            //                            case .student:
                            //                                studentRegistrationFormView?
                            //                                    .selectFirstField()
                            //                            case .externalUser:
                            //                                ()
                            //                            }
                        }
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
                }
            }
            .onChange(of: viewModel.viewDisplayingMode) { newValue in
                withAnimation {
                    viewDisplayingMode = newValue
                }
            }
        }
    }
}

struct RegistrationView_Preview: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        RegistrationView(viewModel: mainComponent.registrationComponent.registrationViewModel)
    }
}
