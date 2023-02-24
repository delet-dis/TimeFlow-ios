//
//  SharedStudentFormView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 24.02.2023.
//

import Foundation
import SwiftUI

struct SharedStudentFormView: View {
    @Binding var viewData: SharedStudentViewData
    @Binding var viewStudentState: SharedStudentViewState

    var body: some View {
        VStack {
            Text(R.string.localizable.studentCard)
                .font(
                    Font(R.font.ralewayBold(size: 24) ??
                        .systemFont(ofSize: 24, weight: .medium))
                )
            TextField(R.string.localizable.studentNumber(),
                      text: $viewData.studentNumber)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextField())
            TextField(R.string.localizable.groupNumber(),
                      text: $viewData.studentNumber)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextField())
        }
        .padding(.horizontal, 20)
    }
}

struct SharedStudentFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(SharedStudentViewData(studentNumber: "")
        ) { binding in
            SharedStudentFormView(viewData: binding, viewStudentState: .constant(SharedStudentViewState(isStudentNumberValid: true, isGroupNumberValid: true)))
        }
    }
}
