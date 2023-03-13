//
//  SharedProfileStudentView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import SwiftUI

struct SharedProfileStudentView: View {
    @Binding var viewData: SharedStudentViewData

    init(
        viewData: Binding<SharedStudentViewData>
    ) {
        self._viewData = viewData
    }

    var body: some View {
        VStack( alignment: .leading, spacing: 5) {
            Text(R.string.localizable.studentCardNumber())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.studentCard(), text: $viewData.studentNumber)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.groupNumber())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.groupNumber(), text: $viewData.groupNumber)
                .modifier(ElevatedTextFieldModifier())
        }
        .padding([.leading, .trailing])
        .disabled(true)
    }
}

struct SharedProfileStudentView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        StatefulPreviewWrapper(SharedStudentViewData(
            userFIO: "",
            genderType: GenderEnum.none.rawValue,
            emailText: "",
            passwordText: "password",
            acccountStatus: "",
            userRole: "",
            confirmPasswordText: "password",
            studentNumber: "",
            groupNumber: ""
        )) { binding in
            SharedProfileStudentView(
                viewData: binding
            )
        }
    }
}
