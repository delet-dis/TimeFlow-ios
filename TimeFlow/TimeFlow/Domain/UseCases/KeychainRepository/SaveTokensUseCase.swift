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
    private let keychainRepository: KeychainRepository

    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(
        authToken: String?,
        refreshToken: String?,
        completion: ((Result<Void, Error>) -> Void)? = nil
    ) {
        if let authToken = authToken {
            keychainRepository.saveValueByKey(
                TokenTypeEnum.auth.rawValue,
                value: authToken,
                completion: refreshToken != nil ? nil : completion
            )
        }

        if let refreshToken = refreshToken {
            keychainRepository.saveValueByKey(
                TokenTypeEnum.refresh.rawValue,
                value: refreshToken,
                completion: completion
            )
        }
    }
}
