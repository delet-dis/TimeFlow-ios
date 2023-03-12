//
//  DisplayingScheduleType.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation

enum DisplayingScheduleType: Codable, Identifiable, CaseIterable {
    case teacher
    case group
    case classroom
    
    var networkingValue: String? {
        switch self {
        case .teacher:
            return R.string.localizable.teacherType()
        case .group:
            return R.string.localizable.group()
        case .classroom:
            return R.string.localizable.classroom()
        }
    }
    
    var rawValue: Int {
        switch self {
        case .teacher:
            return 0
        case .group:
            return 1
        case .classroom:
            return 2
        }
    }
    
    static func getValueFromString(_ string: String) -> Self? {
        switch string {
        case R.string.localizable.teacherType():
            return .teacher
        case R.string.localizable.group():
            return .group
        case R.string.localizable.classroom():
            return .classroom
        default:
            return nil
        }
    }
    
    var id: Int { return self.rawValue }
    
}
