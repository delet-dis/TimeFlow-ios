//
//  GroupStudentUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation
import NeedleFoundation

protocol GroupStudentUseCaseDependency: Dependency {
    var groupStudentUseCaseProvider: GroupStudentUseCase { get }
}

class GroupStudentUseCase {
    private let studentGroupRepository: StudentsGroupRepository

    init(
        studentGroupRepository: StudentsGroupRepository
    ) {
        self.studentGroupRepository = studentGroupRepository
    }

    func execute(
        completion: ((Result<[StudentsGroup], Error>) -> Void)? = nil
    ) {
        studentGroupRepository.getStudentsGroup(
            completion: completion)
    }
}
