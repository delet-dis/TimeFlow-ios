//
//  AuthorizationHelper.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation
import SwiftUI

class AuthorizationOrRegistrationDataHelper {
    static func checkFirstNameField(_ firstName: String) -> Bool {
        return !isEmptyAndBlank(firstName)
    }

    static func checkSecondNameField(_ secondName: String) -> Bool {
        return !isEmptyAndBlank(secondName)
    }

    static func checkMiddleNameField(_ middleName: String) -> Bool {
        return !isEmptyAndBlank(middleName)
    }

    private static var emailPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        // swiftlint:disable:next line_length
        "^(?!\\.)([A-Z0-9a-z_%+-]?[\\.]?[A-Z0-9a-z_%+-])+@[A-Za-z0-9-]{1,20}(\\.[A-Za-z0-9]{1,15}){0,10}\\.[A-Za-z]{2,20}$"
    )

    static func isEmailValid(_ email: String) -> Bool {
        emailPredicate.evaluate(with: email)
    }

    static func arePasswordsValid(firstPassword: String, passwordConfirmation: String) -> Bool {
        firstPassword == passwordConfirmation
    }

    private static func isEmptyAndBlank(_ string: String) -> Bool {
        string.isEmpty && string.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
