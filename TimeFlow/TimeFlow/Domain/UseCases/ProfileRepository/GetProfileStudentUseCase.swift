//
//  GetProfileStudentUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetProfileStudentUseCaseProvider: Dependency {
    var getProfileStudentUseCaseProvider: GetProfileStudentUseCase { get }
}

class GetProfileStudentUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(token: String, completion: ((Result<StudentUser, Error>) -> Void)? = nil) {
        profileRepository.getStudentInfo(token: token, completion: completion)
    }
}
