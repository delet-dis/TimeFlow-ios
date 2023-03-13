//
//  GetClassroomsListUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetClassroomsListUseCaseProvider: Dependency {
    var getClassroomsListUseCase: GetClassroomsListUseCase { get }
}

class GetClassroomsListUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(completion: ((Result<[ClassroomList], Error>) -> Void)? = nil) {
        profileRepository.getClassroomList(completion: completion)
    }
}
