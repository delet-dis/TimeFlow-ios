//
//  TeacherRegistrationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Foundation
import SwiftUI

struct TeacherRegistrationView: View {
    private enum Field: Hashable {
        case firstName, secondName, patronymic, email, password, sex, confrimPassword, contactNumber
    }

    @FocusState private var focusedField: Field?

    @EnvironmentObject private var viewModel: TeacherRegistrationViewModel
    @State private var motionManager = MotionManager()

    var body: some View {
        ScrollViewReader { _ in
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text(R.string.localizable.helloRegister())
                            .font(
                                Font(R.font.ralewayBold(size: 24) ?? .systemFont(ofSize: 24, weight: .medium))
                            )

                        Spacer()
                    }

                    TextField(R.string.localizable.secondName(), text: $viewModel.secondName)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .secondName)
                        .onSubmit {
                            focusedField = .firstName
                        }
                        .modifier(ElevatedTextFieldRegistration())
                    TextField(R.string.localizable.firstName(), text: $viewModel.firstName)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .firstName)
                        .onSubmit {
                            focusedField = .patronymic
                        }
                        .modifier(ElevatedTextFieldRegistration())
                    TextField(R.string.localizable.middleName(), text: $viewModel.middleName)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .patronymic)
                        .onSubmit {
                            focusedField = .email
                        }
                        .modifier(ElevatedTextFieldRegistration())

                    Picker("",
                           selection: $viewModel.genderType) {
                        EmptyView()
                            .tag(GenderPickerEnum.none)

                        Text(R.string.localizable.female())
                            .tag(GenderPickerEnum.FEMALE)

                        Text(R.string.localizable.male())
                            .tag(GenderPickerEnum.MALE)
                    }

                    .pickerStyle(.segmented)

                    .font(Font(R.font.ralewayMedium(size: 15) ?? .systemFont(ofSize: 15, weight: .medium)))

                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
                    }

                    TextField(R.string.localizable.email(), text: $viewModel.emailText)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .email)
                        .onSubmit {
                            focusedField = .password
                        }
                        .modifier(ElevatedTextFieldRegistration())

                    CustomSecureTextField(R.string.localizable.password(), text: $viewModel.passwordText)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .password)
                        .onSubmit {
                            focusedField = .confrimPassword
                        }
                        .modifier(ElevatedTextFieldRegistration())

                    CustomSecureTextField(
                        R.string.localizable.passwordConfirmation(),
                        text: $viewModel.confirmPasswordText
                    )
                    .modifier(ElevatedTextFieldRegistration())
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .confrimPassword)
                    .onSubmit {
                        focusedField = .contactNumber
                    }

                    TextField(R.string.localizable.contactNumber(), text: $viewModel.contactNumber)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .contactNumber)
                        .onSubmit {
                            focusedField = nil
                        }
                        .modifier(ElevatedTextFieldRegistration())
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
                .onAppear {
                    Self.confrimCustomPickerStyle()
                }
                .padding(.horizontal, 15)
            }
            VStack(spacing: 15) {
                Button {} label: {
                    Text(R.string.localizable.register())
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
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(uiColor: R.color.lightYellow() ?? .yellow))
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
                }

                Button {} label: {
                    Text(R.string.localizable.iHaveAnAccount())
                        .font(
                            Font(
                                R.font.ralewayBold(size: 15) ??
                                    .systemFont(ofSize: 15, weight: .medium)
                            )
                        )
                        .foregroundColor(.black)
                }
                .backgroundStyle(.blue)
            }
            .padding(.horizontal, 16)
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct TeacherRegistrationView_Preview: PreviewProvider {
    private static let registrationComponent = RegistrationComponent()

    static var previews: some View {
        TeacherRegistrationView()
            .environmentObject(registrationComponent.teacherRegistrationViewModel)
    }
}
