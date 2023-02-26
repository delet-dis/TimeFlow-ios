//
//  TeacherRegistrationFormView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 24.02.2023.
//

import Foundation
import SwiftUI

struct TeacherRegistrationFormView: View {
    private enum Field: Hashable {
        case contractNumber
    }

    @FocusState private var focusedField: Field?

    @Binding var viewData: TeacherRegistationViewData
    @Binding var viewState: TeacherRegistationViewState

    let lastTextFieldUnselectedClosure: (() -> Void)?

    init(
        viewData: Binding<TeacherRegistationViewData>,
        viewState: Binding<TeacherRegistationViewState>,
        lastTextFieldUnselectedClosure: (() -> Void)? = nil
    ) {
        self._viewData = viewData
        self._viewState = viewState
        self.lastTextFieldUnselectedClosure = lastTextFieldUnselectedClosure
    }

    var body: some View {
        VStack {
            Text(R.string.localizable.employeeContract)
                .font(
                    Font(R.font.ralewayBold(size: 24) ??
                        .systemFont(ofSize: 24, weight: .medium))
                )

            TextField(
                R.string.localizable.contractNumber(),
                text: $viewData.contractNumber
            )
            .focused($focusedField, equals: .contractNumber)
            .textInputAutocapitalization(.never)
            .submitLabel(.done)
            .modifier(ElevatedTextFieldModifier())
            .onSubmit {
                lastTextFieldUnselectedClosure?()
            }
        }
        .padding(.horizontal, 20)
        .modifier(ViewWithReadyKeyboardButtonModifier(focus: $focusedField))
    }
}

struct SharedTeacherFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(
            TeacherRegistationViewData(contractNumber: "")
        ) { binding in
            TeacherRegistrationFormView(
                viewData: binding,
                viewState: .constant(TeacherRegistationViewState(isContractNumberValid: true)
                )
            )
        }
    }
}
