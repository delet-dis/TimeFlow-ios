//
//  ProfileView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import AxisSegmentedView
import SwiftUI

struct SharedProfileView: View {
    private enum Field: Hashable {
        case email, password, gender, confrimPassword, userRole, acccountStatus, userFIO
    }

    @Binding var viewData: SharedProfileViewData

    @Binding var viewState: SharedProfileState

    init(
        viewData: Binding<SharedProfileViewData>,
        viewState: Binding<SharedProfileState>
    ) {
        self._viewData = viewData
        self._viewState = viewState
    }

    var body: some View {
        VStack(spacing: 15) {
            TextField(R.string.localizable.fiO(), text: $viewData.userFIO)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextFieldModifier())
            TextField(R.string.localizable.email(), text: $viewData.emailText)
                .modifier(ElevatedTextFieldModifier())
            TextField(R.string.localizable.role(), text: $viewData.userRole)
                .modifier(ElevatedTextFieldModifier())
            TextField(R.string.localizable.statusUser(), text: $viewData.acccountStatus)
                .modifier(ElevatedTextFieldModifier())
            VStack {
                AxisSegmentedView(selection: $viewData.genderType) {
                    ForEach(GenderProfileEnum.allCases) { gender in
                        Text(gender.savedValue)
                            .font(
                                Font(
                                    R.font.ralewayMedium(size: 15) ??
                                        .systemFont(ofSize: 15, weight: .medium)
                                )
                            )
                            .foregroundColor(
                                viewData.genderType == gender.rawValue ?
                                    .white :
                                    .black
                            )
                            .itemTag(gender.rawValue)
                            .onTapGesture {
                                viewData.genderType = gender.rawValue
                            }
                    }
                } style: {
                    ASCapsuleStyle(
                        backgroundColor: .white,
                        foregroundColor: .init(uiColor: R.color.lightYellow() ?? .yellow),
                        movementMode: .normal
                    )
                }
                .background {
                    RoundedRectangle(cornerRadius: 90)
                        .foregroundColor(.white)
                }
                .frame(height: 53)
            }
            .modifier(ElevatedViewModifier())
        }
    }
}

struct SharedProfileView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        StatefulPreviewWrapper(SharedProfileViewData(
            userFIO: "",
            genderType: GenderEnum.none.rawValue,
            emailText: "",
            passwordText: "password",
            acccountStatus: "",
            userRole: "",
            confirmPasswordText: "password"
        )) { binding in
            SharedProfileView(
                viewData: binding,
                viewState: .constant(
                    SharedProfileState(
                        isPasswordValid: true,
                        isPasswordConfirmationValid: true,
                        arePasswordsEqual: true
                    )
                )
            )
        }
    }
}
