//
//  AuthorizationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct AuthorizationView: View {
    private enum UserField: Hashable {
        case email, password
    }
    
    @EnvironmentObject private var viewModel: AuthorizationViewModel
    
    @FocusState private var focusedField: UserField?
    
    @State private var isValidFields = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField("Почта", text: $viewModel.emailText)
                    .modifier(TextFieldStyle())
                    .font(.custom("Raleway", size: 15))
                    .foregroundColor(
                        Color(UIColor(named: "BlueCustom") ?? .blue))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }
                    .shadow(
                        color: Color.black.opacity(0.9),
                        radius: 8,
                        x: 2,
                        y: 2
                    )
                    
                SecureField("Пароль", text: $viewModel.passwordText)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .modifier(TextFieldStyle())
                    .font(.custom("Raleway", size: 15))
                    .foregroundColor(
                        Color(UIColor(named: "BlueCustom") ?? .blue))
                    .focused($focusedField, equals: .password)
                    .shadow(
                        color: Color.black.opacity(0.9),
                        radius: 8,
                        x: 2,
                        y: 2
                    )
            }
            
            VStack(spacing: 15) {
                // Добавить проверку на валидность полей и
                // отобразить кнопку в другом состоянии
                Spacer()
                Button {
                    focusedField = nil
                    viewModel.login()
                } label: {
                    Text("Войти")
                        .font(.custom("Raleway", size: 15))
                        .foregroundColor(
                            Color(UIColor(named: "BlueCustom") ?? .blue))
                }
                .padding()
                .cornerRadius(16)
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 15
                    ).stroke(
                        LinearGradient(gradient: Gradient(colors:
                            [Color(UIColor(named:
                                "GradientYellow")
                                ?? .white),
                            Color(UIColor(named:
                                "GradientLightYellow")
                                ?? .white),
                            Color(UIColor(named:
                                "GradientPurple")
                                ?? .white)]),
                        startPoint: .bottomTrailing, endPoint: .topLeading)
                    )
                )
                .shadow(
                    color: Color.black.opacity(0.9),
                    radius: 8,
                    x: 2,
                    y: 2
                )
                .padding(.horizontal, 15)
                
                Button {
                    viewModel.setRegisrationViewClousure?()
                } label: {
                    Text("Зарегистрироваться")

                        .font(.custom("Raleway", size: 15))
                        .foregroundColor(
                            Color(UIColor(named: "BlueCustom") ?? .blue))
                }
                .padding(.horizontal, 10)
            }
            .ignoresSafeArea(.keyboard)
        }
        .background(
            LinearGradient(gradient: Gradient(colors:
                [Color(UIColor(named:
                    "GradientYellow")
                    ?? .white),
                Color(UIColor(named:
                    "GradientLightYellow")
                    ?? .white),
                Color(UIColor(named:
                    "GradientPurple")
                    ?? .white)]),
            startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button("Готово") {
                        focusedField = nil
                    }
                    .foregroundColor(
                        Color(UIColor(named: "BlueCustom") ?? .blue))

                    Spacer()
                }
            }
        }
        // Добавить Алерт
    }
}
