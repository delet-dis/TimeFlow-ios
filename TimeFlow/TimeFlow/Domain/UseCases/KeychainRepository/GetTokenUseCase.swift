//
//  GetTokenUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 08.03.2023.
//

import Foundation
import NeedleFoundation

protocol GetTokenUseCaseDependency: Dependency {
    var getTokenUseCaseProvider: GetTokenUseCase { get }
}

class GetTokenUseCase {
    private static let tokenKey = "AUTH_TOKEN"

    private let keychainRepository: KeychainRepository

    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(completion: ((Result<String, Error>) -> Void)? = nil) {
        keychainRepository.getValueByKey(Self.tokenKey, completion: completion)
    }
}
