//
//  SharedStudentFormView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 24.02.2023.
//

import AxisSegmentedView
import Foundation
import SwiftUI

struct StudentRegistrationFormView: View {
    private enum Field: Hashable {
        case studentNumber, groupNumber
    }

    @FocusState private var focusedField: Field?

    @Binding var viewData: StudentRegistrationViewData
    @Binding var viewState: StudentRegistationViewState
    @State private var displayingGroups: [StudentGroup]

    let lastTextFieldUnselectedClosure: (() -> Void)?

    init(
        viewData: Binding<StudentRegistrationViewData>,
        viewState: Binding<StudentRegistationViewState>,
        displayingGroups: [StudentGroup],
        lastTextFieldUnselectedClosure: (() -> Void)? = nil
    ) {
        self._viewData = viewData
        self._viewState = viewState
        self.lastTextFieldUnselectedClosure = lastTextFieldUnselectedClosure
        self.displayingGroups = displayingGroups
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

                HStack {
                    Text(R.string.localizable.groupNumber)
                        .padding(.horizontal, 20)
                        .font(
                            Font(
                                R.font.ralewayMedium(size: 15) ??
                                    .systemFont(ofSize: 15, weight: .medium)
                            )
                        ).foregroundColor(Color(UIColor.lightGray))

                    Spacer()

                    Picker("", selection: $viewData.groupId) {
                        ForEach(displayingGroups) { group in
                            if let groupNumber = group.number {
                                Text(String(groupNumber))
                                    .font(
                                        Font(
                                            R.font.ralewayMedium(size: 15) ??
                                                .systemFont(ofSize: 15, weight: .medium)
                                        )
                                    )
                            }
                        }
                    }
                    .frame(minHeight: 49)
                    .tint(Color(R.color.lightYellow))
                    .onAppear {
                        if let firstDispalyingFroup = displayingGroups.first {
                            viewData.groupId = firstDispalyingFroup.id
                        }
                    }
                }
                .modifier(ElevatedViewModifier())
            }
        }
        .padding(.horizontal, 20)
        .modifier(ViewWithReadyKeyboardButtonModifier(focus: $focusedField))
    }
}

struct SharedStudentFormView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()
    static var previews: some View {
        StatefulPreviewWrapper(
            StudentRegistrationViewData(studentNumber: "")
        ) { binding in
            StudentRegistrationFormView(
                viewData: binding,
                viewState: .constant(
                    StudentRegistationViewState(isStudentNumberValid: true, isGroupNumberValid: true)
                ), displayingGroups: [StudentGroup(id: UUID().uuidString, number: 123)]
            )
        }
    }
}
