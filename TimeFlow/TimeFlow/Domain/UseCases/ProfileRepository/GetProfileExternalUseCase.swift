//
//  GetProfileUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetProfileExternalUseCaseProvider: Dependency {
    var getProfileUseCaseProvider: GetProfileExternalUseCase { get }
}

class GetProfileExternalUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(token: String, completion: ((Result<User, Error>) -> Void)? = nil) {
        profileRepository.getExternalUserInfo(token: token, completion: completion)
    }
}
