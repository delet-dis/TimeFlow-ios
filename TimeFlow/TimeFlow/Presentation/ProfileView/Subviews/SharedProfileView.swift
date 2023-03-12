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


    init(
        viewData: Binding<SharedProfileViewData>
    ) {
        self._viewData = viewData
    }

    var body: some View {
        VStack( alignment: .leading, spacing: 5) {
            Text(R.string.localizable.fiO())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.fiO(), text: $viewData.userFIO)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.email())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.email(), text: $viewData.emailText)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.role())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.role(), text: $viewData.userRole)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.statusUser())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.statusUser(), text: $viewData.acccountStatus)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.gender())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 15, weight: .medium)
                    )
                )
                .padding([.leading])
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
        .padding([.leading, .trailing])
        .disabled(true)
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
                viewData: binding
            )
        }
    }
}
