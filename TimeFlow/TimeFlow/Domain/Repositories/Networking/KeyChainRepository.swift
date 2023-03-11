//
//  KeychainRepository.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

protocol RefreshTokenRepository {
    func changeValueByKey(_ key: String,completion: ((Result<RefreshTokenData, Error>) -> Void)?)
}
