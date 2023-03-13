//
//  GetUserRoleUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetUserRoleUseCaseProvider: Dependency {
    var getUserRoleUseCaseProvider: GetUserRoleUseCase { get }
}

class GetUserRoleUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(token: String, completion: ((Result<String, Error>) -> Void)? = nil) {
        profileRepository.getRole(token: token, completion: completion)
    }
}
