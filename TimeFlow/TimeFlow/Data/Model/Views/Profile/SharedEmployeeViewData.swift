//
//  SharedEmployeeViewData.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation

struct SharedEmployeeViewData {
    var userFIO: String = ""
    var genderType = GenderEnum.none.rawValue
    var emailText: String = ""
    var passwordText: String = ""
    var acccountStatus: String = ""
    var userRole: String = ""
    var confirmPasswordText: String = ""
    var contractNumber: String = ""
    var postRole: String = ""
    var postName: String = ""
}
