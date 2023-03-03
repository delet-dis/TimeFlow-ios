//
//  DefaultsRepositoryErrorsEnum.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation

enum DefaultsRepositoryErrorsEnum: Error {
    case unableToGetData
}

extension DefaultsRepositoryErrorsEnum: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToGetData: return R.string.localizable.unableToGetData()
        }
    }
}
