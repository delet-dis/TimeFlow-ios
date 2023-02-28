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
        completion: ((Result<Bool, Error>) -> Void)?
    )
    func logout(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
}
