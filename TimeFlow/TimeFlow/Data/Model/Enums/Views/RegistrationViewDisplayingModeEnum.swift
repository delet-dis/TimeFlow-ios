//
//  RegistrationViewDisplayingModeEnum.swift
//  TimeFlow
//
//  Created by Igor Efimov on 20.02.2023.
//

import Foundation

enum RegistrationViewDisplayingModeEnum: Int, CaseIterable, Identifiable {
    case teacher
    case student
    case externalUser

    var rawValue: Int {
        switch self {
        case .teacher:
            return 0
        case .externalUser:
            return 2
        case .student:
            return 1
        }
    }

    var savedValue: String {
        switch self {
        case .teacher:
            return R.string.localizable.teacher()
        case .externalUser:
            return R.string.localizable.externalUser()
        case .student:
            return R.string.localizable.student()
        }
    }

    var id: Int { return self.rawValue }
}
