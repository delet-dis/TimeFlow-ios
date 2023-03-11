//
//  LessonTypeEnumExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 10.03.2023.
//

import Foundation

extension LessonTypeEnum {
    static func getByNetworkingValue(_ networkingValue: String) -> Self? {
        switch networkingValue {
        case "LECTURE":
            return .lecture
        case "SEMINAR":
            return .seminar
        case "PRACTICAL_LESSON":
            return .practicalLesson
        case "LABORATORY_LESSON":
            return .laboratoryLesson
        case "EXAM":
            return .exam
        default:
            return nil
        }
    }
}
