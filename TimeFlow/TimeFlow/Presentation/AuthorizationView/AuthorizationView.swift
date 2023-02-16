//
//  AuthorizationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation
import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject private var viewModel: AuthorizationViewModel

    var body: some View {
        ZStack {
            TextField("Почта", text: $viewModel.emailText)
                .modifier(TextFieldStyle())
            Spacer()
            SecureField("Пароль", text: $viewModel.passwordText)
                .modifier(TextFieldStyle())
        }
    }
}


