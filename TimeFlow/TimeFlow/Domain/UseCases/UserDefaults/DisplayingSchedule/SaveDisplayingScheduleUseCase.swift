//
//  SaveDisplayingScheduleUseCase.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import Foundation
import SwiftyUserDefaults

class SaveDisplayingScheduleUseCase {
    func execute(
        displayingSchedule: DisplayingSchedule?,
        completion: ((Result<Void, Error>) -> Void)? = nil
    ) {
        Defaults[\.displayingSchedule] = displayingSchedule

        completion?(.success(()))
    }
}
