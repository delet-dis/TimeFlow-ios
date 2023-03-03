//
//  AuthorizationRequest.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

struct AuthorizationRequest: Codable {
    let email: String
    let password: String
}
