//
//  RefreshTokenUseCase.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation
import NeedleFoundation

protocol RefreshTokenUseCaseProvider: Dependency {
    var refreshTokenUseCase: RefreshTokenUseCase { get }
}

class RefreshTokenUseCase {
    private static let tokenKey = "REFRESH_TOKEN"

    private let keychainRepository: RefreshTokenRepository

    init(keychainRepository: RefreshTokenRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(completion: ((Result<RefreshTokenData, Error>) -> Void)? = nil) {
        keychainRepository.changeValueByKey(Self.tokenKey, completion: completion)
    }
}
