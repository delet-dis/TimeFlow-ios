//
//  ExternalUserViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Foundation


class ExternalUserRegistrationViewModel: ObservableObject {
    @Published var secondName = ""
    @Published var firstName = ""
    @Published var middleName = ""
    @Published var genderType: GenderPickerEnum = .none
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var confirmPasswordText = ""
}
