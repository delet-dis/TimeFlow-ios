//
//  GetTeacherLessonsUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetTeacherLessonsUseCaseProvider: Dependency {
    var getTeacherLessonsUseCaseProvider: GetTeacherLessonsUseCase { get }
}

class GetTeacherLessonsUseCase {
    private let lessonsRepository: LessonsRepository

    init(lessonsRepository: LessonsRepository) {
        self.lessonsRepository = lessonsRepository
    }

    func execute(
        teacherId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<TeacherResponse, Error>) -> Void)? = nil
    ) {
        lessonsRepository.getTeacherLessons(
            teacherId: teacherId,
            startDate: startDate,
            endDate: endDate,
            completion: completion
        )
    }
}
