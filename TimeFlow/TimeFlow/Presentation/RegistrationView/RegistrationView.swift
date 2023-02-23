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
                .frame(height: 60)
            }
            .padding(.horizontal, 24)

            ScrollView {
                SharedRegistrationFormView(
                    viewData: $viewModel.sharedRegistrationData,
                    viewState: $viewModel.sharedRegistrationFieldsState
                )
                .padding(.top, 20)
                .padding(.horizontal, 24)

                switch viewDisplayingMode {
                case .teacher:
                    viewModel.registrationComponent?.teacherRegistrationView
                case .student:
                    viewModel.registrationComponent?.studentRegistrationView
                case .externalUser:
                    viewModel.registrationComponent?.externalUserRegistrationView
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

struct RegistrationView_Preview: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        RegistrationView()
            .environmentObject(mainComponent.registrationComponent.registrationViewModel)
    }
}
