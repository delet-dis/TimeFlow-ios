//
//  GenderProfileEnum.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 08.03.2023.
//

import Foundation

enum GenderProfileEnum: Int, CaseIterable, Identifiable, Codable {
    case female
    case male

    var rawValue: Int {
        switch self {
        case .female:
            return 0
        case .male:
            return 1
        }
    }

    var savedValue: String {
        switch self {
        case .female:
            return R.string.localizable.female()
        case .male:
            return R.string.localizable.male()
        }
    }

    var id: Int { return self.rawValue }

    var networkingValue: String? {
        switch self {
        case .female:
            return "FEMALE"
        case .male:
            return "MALE"
        }
    }
}
