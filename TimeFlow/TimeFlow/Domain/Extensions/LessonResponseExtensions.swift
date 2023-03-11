//
//  LessonResponseExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 10.03.2023.
//

import Foundation

extension LessonResponse {
    func getType() -> LessonTypeEnum? {
        return LessonTypeEnum.getByNetworkingValue(self.lessonType)
    }
}
