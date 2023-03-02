//
//  StudentGroupsRepository.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 01.03.2023.
//

import Foundation

protocol StudentGroupsRepository {
    func getStudentGroups(
        completion: ((Result<[StudentGroup], Error>) -> Void)?
    )
}
