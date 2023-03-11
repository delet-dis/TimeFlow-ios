//
//  NetworkingKeysEnum.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 10.03.2023.
//

import Foundation

    
enum NetworkingKeysEnum: String, CaseIterable, Identifiable, Codable {
    case password
    case email
    case user
    case student
    case role
    case employee
    case signOut

    var rawValue: String {
        switch self {
        case .password:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.password)"
        case .email:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.email)"
        case .user:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.user)"
        case .student:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.student)"
        case .role:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.role)"
        case .employee:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.accountSegment)/\(NetworkingConstants.employee)"
        case .signOut:
            return NetworkingConstants.baseUrl +
                "\(NetworkingConstants.signOut)"
        }
    }

    var id: String { return self.rawValue }
}
