//
//  LessonsListView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 12.03.2023.
//

import SwiftUI

struct LessonsListView: View {
    let dispalyingLessons: [LessonResponse]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(Array(dispalyingLessons.enumerated()), id: \.offset) { index, lesson in
                    LessonView(displayingLesson: lesson)
                        .padding(.top, index == 0 ? 20 : 0)
                        .padding(.bottom, index == dispalyingLessons.count - 1 ? 50 : 0)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct LessonsList_Previews: PreviewProvider {
    static var previews: some View {
        LessonsListView(dispalyingLessons: [])
    }
}
