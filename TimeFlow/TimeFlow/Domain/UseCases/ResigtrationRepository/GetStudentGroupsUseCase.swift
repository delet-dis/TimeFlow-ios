//
//  GroupStudentUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetStudentGroupsUseCaseDependency: Dependency {
    var getStudentGroupsUseCaseProvider: GetStudentGroupsUseCase { get }
}

class GetStudentGroupsUseCase {
    private let studentGroupRepository: StudentGroupsRepository

    init(
        studentGroupRepository: StudentGroupsRepository
    ) {
        self.studentGroupRepository = studentGroupRepository
    }

    func execute(
        completion: ((Result<[StudentGroup], Error>) -> Void)? = nil
    ) {
        studentGroupRepository.getStudentGroups(completion: completion)
    }
}
