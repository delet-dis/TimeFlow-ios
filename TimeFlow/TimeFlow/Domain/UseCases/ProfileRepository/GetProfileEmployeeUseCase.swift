//
//  GetProfileEmployeeUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetProfileEmployeeUseCaseCaseProvider: Dependency {
    var getProfileEmployeeUseCaseCaseProvider: GetProfileEmployeeUseCaseCase { get }
}

class GetProfileEmployeeUseCaseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(token: String, completion: ((Result<EmployeeUser, Error>) -> Void)? = nil) {
        profileRepository.getEmployeeInfo(token: token, completion: completion)
    }
}
