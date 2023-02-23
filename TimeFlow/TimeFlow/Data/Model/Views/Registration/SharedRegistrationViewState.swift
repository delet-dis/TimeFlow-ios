//
//  SharedRegistrationViewState.swift
//  TimeFlow
//
//  Created by Igor Efimov on 23.02.2023.
//

import Foundation

struct SharedRegistrationViewState {
    var isSecondNameValid: Bool = true
    var isFirstNameValid: Bool = true
    var isMiddleNameValid: Bool = true
    var isEmailValid: Bool = true
    var isPasswordValid: Bool = true
    var isPasswordConfirmationValid: Bool = true
    var arePasswordsEqual: Bool = true
    var isGenderValid: Bool = true
}
