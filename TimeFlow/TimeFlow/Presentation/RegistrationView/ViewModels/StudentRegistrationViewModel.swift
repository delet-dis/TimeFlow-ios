//
//  StudentRegistrationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import Foundation

class StudentRegistrationViewModel: ObservableObject {
    @Published var secondName = ""
    @Published var firstName = ""
    @Published var middleName = ""
    @Published var genderType: GenderEnum = .none
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var confirmPasswordText = ""
}
