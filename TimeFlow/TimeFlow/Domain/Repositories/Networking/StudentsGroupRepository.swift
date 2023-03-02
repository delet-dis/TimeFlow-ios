//
//  StudentsGroupRepository.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation

protocol StudentsGroupRepository {
    func getStudentsGroup(
        completion: ((Result<[StudentsGroup], Error>) -> Void)?
    )
}
