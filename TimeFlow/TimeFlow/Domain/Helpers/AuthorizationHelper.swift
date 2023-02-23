//
//  AuthorizationHelper.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 20.02.2023.
//

import Foundation
import SwiftUI

final class AuthorizationOrRegistrationDataHelper {
    private static let passwordPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        #"^(?=\S*)(?=\S*)(?=\S*\d)(?=\S*([^\w\s]|[_]))\S{8,32}$"#
    )

    private static let emailPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        // swiftlint:disable:next line_length
        "^(?!\\.)([A-Z0-9a-z_%+-]?[\\.]?[A-Z0-9a-z_%+-])+@[A-Za-z0-9-]{1,20}(\\.[A-Za-z0-9]{1,15}){0,10}\\.[A-Za-z]{2,20}$"
    )

    static func isPasswordValid(_ password: String) -> Bool {
        passwordPredicate.evaluate(with: password)
    }

    static func isSecondNameValid(_ secondName: String) -> Bool {
        !secondName.isEmptyAndBlank
    }

    static func isMiddleNameValid(_ middleName: String) -> Bool {
        !middleName.isEmptyAndBlank
    }

    static func isFirstNameValid(_ firstName: String) -> Bool {
        !firstName.isEmptyAndBlank
    }

    static func isEmailValid(_ email: String) -> Bool {
        emailPredicate.evaluate(with: email)
    }

    static func arePasswordsValid(firstPassword: String, passwordConfirmation: String) -> Bool {
        firstPassword == passwordConfirmation
    }
}
