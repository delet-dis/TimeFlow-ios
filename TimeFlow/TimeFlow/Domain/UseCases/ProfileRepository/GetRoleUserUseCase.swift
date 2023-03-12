//
//  GetRoleUserUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetRoleUserUseCaseProvider: Dependency {
    var getRoleUserUseCaseProvider: GetRoleUserUseCase { get }
}

class GetRoleUserUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(token: String, completion: ((Result<String, Error>) -> Void)? = nil) {
        profileRepository.getRole(token: token, completion: completion)
    }
}
