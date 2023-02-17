//
//  AuthRepository.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

protocol AuthRepository {
    func login(userCredentials: UserCredentials, completion: ((Result<Bool, Error>) -> Void)?)
    func logout(userCredentials: UserCredentials, completion: ((Result<VoidResponse, Error>) -> Void)?)
}