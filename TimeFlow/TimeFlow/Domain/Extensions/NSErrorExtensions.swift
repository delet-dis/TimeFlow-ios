//
//  NSErrorExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 16.02.2023.
//

import Foundation

extension NSError {
    static func createErrorWithLocalizedDescription(_ text: String) -> NSError {
        NSError(
            domain: Bundle.main.bundleIdentifier ?? "com.hits.TimeFlow",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: text]
        )
    }
}
