//
//  SharedRegistrationFormView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 23.02.2023.
//

import AxisSegmentedView
import SwiftUI

struct SharedRegistrationFormView: View {
    private enum Field: Hashable {
        case firstName, secondName, patronymic, email, password, gender, confrimPassword
    }

    @FocusState private var focusedField: Field?

    @Binding var viewData: SharedRegistrationViewData
    @Binding var viewState: SharedRegistrationViewState

    let lastTextFieldUnselectedClosure: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 15) {
            Group {
                TextField(R.string.localizable.secondName(), text: $viewData.secondName)
                    .textInputAutocapitalization(.words)
                    .keyboardType(.namePhonePad)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .secondName)
                    .onSubmit {
                        focusedField = .firstName
                    }

                TextField(R.string.localizable.firstName(), text: $viewData.firstName)
                    .textInputAutocapitalization(.words)
                    .keyboardType(.namePhonePad)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .firstName)
                    .onSubmit {
                        focusedField = .patronymic
                    }

                TextField(R.string.localizable.middleName(), text: $viewData.middleName)
                    .textInputAutocapitalization(.words)
                    .keyboardType(.namePhonePad)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .patronymic)
                    .onSubmit {
                        focusedField = .email
                    }
            }
            .modifier(ElevatedTextField())

            Group {
                TextField(R.string.localizable.email(), text: $viewData.emailText)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }

                CustomSecureTextField(R.string.localizable.password(), text: $viewData.passwordText)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = .confrimPassword
                    }

                CustomSecureTextField(
                    R.string.localizable.passwordConfirmation(),
                    text: $viewData.confirmPasswordText
                )
                .focused($focusedField, equals: .confrimPassword)
                .onSubmit {
                    lastTextFieldUnselectedClosure?()
                }
            }
            .modifier(ElevatedTextField())
            .disableAutocorrection(true)
            .submitLabel(.next)
            .textInputAutocapitalization(.never)

            VStack {
                AxisSegmentedView(selection: $viewData.genderType) {
                    ForEach(GenderEnum.allCases) { gender in
                        Text(gender.savedValue)
                            .itemTag(gender.rawValue)
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

struct SharedRegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(SharedRegistrationViewData(
            secondName: "Second name",
            firstName: "First name",
            middleName: "Middle name",
            genderType: GenderEnum.none.rawValue,
            emailText: "Email",
            passwordText: "password",
            confirmPasswordText: "password"
        )) { binding in
            SharedRegistrationFormView(
                viewData: binding,
                viewState: .constant(
                    SharedRegistrationViewState(
                        isSecondNameValid: true,
                        isFirstNameValid: true,
                        isMiddleNameValid: true,
                        isEmailValid: true,
                        isPasswordValid: true,
                        isPasswordConfirmationValid: true,
                        arePasswordsEqual: true,
                        isGenderValid: true
                    )
                )
            )
        }
    }
}
