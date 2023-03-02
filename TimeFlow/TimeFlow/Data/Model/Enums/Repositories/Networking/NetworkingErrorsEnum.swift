//
//  NetworkingErrorsEnum.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

enum NetworkingErrorsEnum: Error {
    case unableToGetData
    case wrongUserCredentials
}

extension NetworkingErrorsEnum: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToGetData: return R.string.localizable.unableToGetData()
        case .wrongUserCredentials: return R.string.localizable.wrongUserCredentials()
        }
    }
}
