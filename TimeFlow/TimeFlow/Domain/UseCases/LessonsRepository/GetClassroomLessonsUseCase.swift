//
//  GetClassroomLessonsUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetClassroomLessonsUseCaseProvider: Dependency {
    var getClassroomLessonsUseCaseProvider: GetClassroomLessonsUseCase { get }
}

class GetClassroomLessonsUseCase {
    private let lessonsRepository: LessonsRepository

    init(lessonsRepository: LessonsRepository) {
        self.lessonsRepository = lessonsRepository
    }

    func execute(
        classroomId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<ClassroomResponse, Error>) -> Void)? = nil
    ) {
        lessonsRepository.getClassroomLessons(
            classroomId: classroomId,
            startDate: startDate,
            endDate: endDate,
            completion: completion
        )
    }
}
