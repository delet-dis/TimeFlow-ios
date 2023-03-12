//
//  GetDisplayingScheduleUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import SwiftyUserDefaults

class GetDisplayingScheduleUseCase {
    func execute(completion: ((Result<DisplayingSchedule?, Error>) -> Void)? = nil) {
        completion?(.success(Defaults[\.displayingSchedule]))
    }
}
