//
//  RegistrationData.swift
//  TimeFlow
//
//  Created by Igor Efimov on 23.02.2023.
//

import Foundation

struct SharedRegistrationViewData {
    var secondName: String = ""
    var firstName: String = ""
    var middleName: String = ""
    var genderType: Int = GenderEnum.none.rawValue
    var emailText: String = ""
    var passwordText: String = ""
    var confirmPasswordText: String = ""
}
