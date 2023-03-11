//
//  CalendarRepository.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 11.03.2023.
//

import Foundation

protocol LessonsRepository {
    func getTeacherLessons(teacherId: String,
                           startDate: String,
                           endDate: String,
                           completion: ((Result<TeacherResponse, Error>) -> Void)?)

    func getStudentGroupLessons(groupId: String,
                                startDate: String,
                                endDate: String,
                                completion: ((Result<GroupResponse, Error>) -> Void)?)

    func getClassroomLessons(classRoomId: String,
                             startDate: String,
                             endDate: String,
                             completion: ((Result<ClassroomResponse, Error>) -> Void)?)
}
