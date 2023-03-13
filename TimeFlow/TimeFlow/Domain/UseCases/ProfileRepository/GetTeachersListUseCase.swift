//
//  GetTeachersListUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetTeachersListUseCaseProvider: Dependency {
    var getTeachersListUseCaseProvider: GetTeachersListUseCase { get }
}

class GetTeachersListUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(completion: ((Result<[TeachersList], Error>) -> Void)? = nil) {
        profileRepository.getTeachersList(completion: completion)
    }
}
