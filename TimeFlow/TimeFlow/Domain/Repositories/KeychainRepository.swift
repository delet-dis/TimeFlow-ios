//
//  KeychainRepository.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation

protocol KeychainRepository {
    func getValueByKey(_ key: String, completion: ((Result<String, Error>) -> Void)?)
    func saveValueByKey(_ key: String, value: String, completion: ((Result<Void, Error>) -> Void)?)
}
