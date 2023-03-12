//
//  GetStudentGroupLessonsUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetStudentGroupLessonsUseCaseProvider: Dependency {
    var getStudentGroupLessonsUseCaseProvider: GetStudentGroupLessonsUseCase { get }
}

class GetStudentGroupLessonsUseCase {
    private let lessonsRepository: LessonsRepository

    init(lessonsRepository: LessonsRepository) {
        self.lessonsRepository = lessonsRepository
    }

    func execute(
        groupId: String,
        startDate: String,
        endDate: String,
        completion: ((Result<GroupResponse, Error>) -> Void)? = nil
    ) {
        lessonsRepository.getStudentGroupLessons(
            groupId: groupId,
            startDate: startDate,
            endDate: endDate,
            completion: completion
        )
    }
}
