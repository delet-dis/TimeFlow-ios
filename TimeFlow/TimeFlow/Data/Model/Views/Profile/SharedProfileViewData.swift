//
//  SharedProfileViewData.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import Foundation

struct SharedProfileViewData {
    var userFIO: String = ""
    var genderType = GenderEnum.none.rawValue
    var emailText: String = ""
    var passwordText: String = ""
    var acccountStatus: String = ""
    var userRole: String = ""
    var confirmPasswordText: String = ""
}
