//
//  GenderPickerEnum.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Foundation

enum GenderEnum: Int, CaseIterable, Identifiable, Codable {
    case female
    case none
    case male

    var rawValue: Int {
        switch self {
        case .female:
            return 0
        case .none:
            return 1
        case .male:
            return 2
        }
    }

    var savedValue: String {
        switch self {
        case .female:
            return R.string.localizable.female()
        case .male:
            return R.string.localizable.male()
        case .none:
            return R.string.localizable.unselected()
        }
    }

    var id: Int { return self.rawValue }

    var networkingValue: String? {
        switch self {
        case .female:
            return "FEMALE"
        case .male:
            return "MALE"
        case .none:
            return nil
        }
    }
    static func getValueFromString(_ gender: String) -> Self? {
        switch gender {
        case "FEMALE":
            return .female
        case "MALE":
            return .male
        default:
            return nil
        }
    }
}
