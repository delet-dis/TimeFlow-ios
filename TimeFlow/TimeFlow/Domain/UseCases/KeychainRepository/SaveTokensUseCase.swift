//
//  SaveTokensUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import NeedleFoundation

protocol SaveTokensUseCaseDependency: Dependency {
    var saveTokenUseCaseProvider: SaveTokensUseCase { get }
}

class SaveTokensUseCase {
    private static let authTokenKey = "AUTH_TOKEN"
    private static let refreshTokenKey = "REFRESH_TOKEN"

    private let keychainRepository: KeychainRepository

    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(
        authToken: String,
        refreshToken: String,
        completion: ((Result<Void, Error>) -> Void)? = nil
    ) {
        keychainRepository.saveValueByKey(Self.authTokenKey, value: authToken, completion: nil)
        keychainRepository.saveValueByKey(Self.refreshTokenKey, value: refreshToken, completion: completion)
    }
}
