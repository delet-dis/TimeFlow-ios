//
//  DefaultsKeysExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var isAuthorized: DefaultsKey<Bool?> { .init("isAuthorized", defaultValue: false) }
}
