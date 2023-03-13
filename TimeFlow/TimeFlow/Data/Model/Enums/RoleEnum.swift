//
//  RoleEnum.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 11.03.2023.
//

import Foundation

enum RoleEnum {
    case user
    case employee
    case student
    
    var networkingValue: String? {
        switch self {
        case .user:
            return R.string.localizable.externalUserRole()
        case .employee:
            return R.string.localizable.teacherRole()
        case .student:
            return R.string.localizable.studentRole()
        }
    }
    
    
}
