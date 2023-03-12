//
//  GetAuthStatusUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation
import SwiftyUserDefaults

class GetAuthStatusUseCase {
    func execute(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        guard let isAuthorized = Defaults[\.isAuthorized] else {
            completion?(.failure(DefaultsRepositoryErrorsEnum.unableToGetData))

            return
        }

        completion?(.success(isAuthorized))
    }
}
