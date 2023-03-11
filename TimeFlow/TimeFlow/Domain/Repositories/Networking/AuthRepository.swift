//
//  AuthRepository.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

protocol AuthRepository {
    func login(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    )

    func logout(
        token: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )

    func refreshToken(
        refreshTokenRequest: RefreshTokenRequest,
        completion: ((Result<LoginResponse, Error>) -> Void)?
    )
}
