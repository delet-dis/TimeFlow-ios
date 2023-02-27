//
//  SharedStudentFormView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 24.02.2023.
//

import Foundation
import SwiftUI

struct StudentRegistrationFormView: View {
    private enum Field: Hashable {
        case studentNumber, groupNumber
    }

    @FocusState private var focusedField: Field?

    @Binding var viewData: StudentRegistrationViewData
    @Binding var viewState: StudentRegistationViewState

    let lastTextFieldUnselectedClosure: (() -> Void)?

    init(
        viewData: Binding<StudentRegistrationViewData>,
        viewState: Binding<StudentRegistationViewState>,
        lastTextFieldUnselectedClosure: (() -> Void)? = nil
    ) {
        self._viewData = viewData
        self._viewState = viewState
        self.lastTextFieldUnselectedClosure = lastTextFieldUnselectedClosure
    }

    var body: some View {
        VStack {
            Text(R.string.localizable.studentCard)
                .font(
                    Font(R.font.ralewayBold(size: 24) ??
                            .systemFont(ofSize: 24, weight: .medium))
                )

            VStack(spacing: 15) {
                TextField(
                    R.string.localizable.studentNumber(),
                    text: $viewData.studentNumber
                )
                .focused($focusedField, equals: .studentNumber)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextFieldModifier())

                TextField(
                    R.string.localizable.groupNumber(),
                    text: $viewData.groupNumber
                )
                .focused($focusedField, equals: .groupNumber)
                .textInputAutocapitalization(.never)
                .submitLabel(.done)
                .modifier(ElevatedTextFieldModifier())
                .onSubmit {
                    lastTextFieldUnselectedClosure?()
                }
            }
        }
        .padding(.horizontal, 20)
        .modifier(ViewWithReadyKeyboardButtonModifier(focus: $focusedField))
    }
}

struct SharedStudentFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(
            StudentRegistrationViewData(studentNumber: "")
        ) { binding in
            StudentRegistrationFormView(
                viewData: binding,
                viewState: .constant(
                    StudentRegistationViewState(isStudentNumberValid: true, isGroupNumberValid: true)
                )
            )
        }
    }
}
