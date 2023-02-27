//
//  RegistrationData.swift
//  TimeFlow
//
//  Created by Igor Efimov on 27.02.2023.
//

import Foundation

protocol RegistrationData {
    var email: String { get set }
    var name: String { get set }
    var surname: String { get set }
    var patronymic: String { get set }
    var password: String { get set }
    var sex: Int { get set }
}
