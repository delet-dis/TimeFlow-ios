//
//  AccountStatusEnum.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
enum AccountStatusEnum: String, Codable {
    case activate
    case pending
    case denied
    
    var networkingValue: String? {
        switch self {
        case .activate:
            return R.string.localizable.activate()
        case .pending:
            return R.string.localizable.pending()
        case .denied:
            return R.string.localizable.denied()
        }
    }
    
    static func getValueFromString(_ status: String) -> Self? {
        switch status {
        case "ACTIVATED":
            return .activate
        case "PENDING":
            return .pending
        case "REJECTED":
            return .denied
        default:
            return nil
        }
    }
    
}
