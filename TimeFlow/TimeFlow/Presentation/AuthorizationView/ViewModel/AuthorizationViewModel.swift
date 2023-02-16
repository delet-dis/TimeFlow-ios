//
//  AuthorizationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 16.02.2023.
//

import Foundation

class AuthorizationViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
}
