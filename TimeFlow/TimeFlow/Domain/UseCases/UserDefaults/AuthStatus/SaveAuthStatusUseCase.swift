//
//  SaveAuthStatusUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import SwiftyUserDefaults

class SaveAuthStatusUseCase {
    func execute(isAuthorized: Bool, completion: ((Result<Void, Error>) -> Void)? = nil) {
        Defaults[\.isAuthorized] = isAuthorized

        completion?(.success(()))
    }
}
