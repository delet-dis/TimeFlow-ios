//
//  RoleEnumExtensions.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 11.03.2023.
//

import Foundation

extension RoleEnum {
    static func getValueFromString(_ string: String) -> Self? {
        switch string {
        case "ROLE_USER":
            return .user
        case "ROLE_STUDENT":
            return .student
        case "ROLE_EMPLOYEE":
            return .employee
        default:
            return nil
        }
    }
}
