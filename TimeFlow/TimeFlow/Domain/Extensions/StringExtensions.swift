//
//  StringExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 23.02.2023.
//

import Foundation

extension String {
    var isEmptyAndBlank: Bool {
        self.isEmpty && self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
