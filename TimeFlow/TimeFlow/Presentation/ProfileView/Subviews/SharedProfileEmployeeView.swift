//
//  SharedProfileEmployeeView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 12.03.2023.
//

import Foundation
import SwiftUI

struct SharedProfileEmployeeView: View {
    @Binding var viewData: SharedEmployeeViewData

    init(
        viewData: Binding<SharedEmployeeViewData>
    ) {
        self._viewData = viewData
    }

    var body: some View {
        VStack( alignment: .leading, spacing: 5) {
            Text(R.string.localizable.contractNumber())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.contractNumber(), text: $viewData.contractNumber)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.groupNumber())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.postRole(), text: $viewData.postRole)
                .modifier(ElevatedTextFieldModifier())
            Text(R.string.localizable.groupNumber())
                .font(
                    Font(
                        R.font.ralewayBold(size: 15) ??
                            .systemFont(ofSize: 10, weight: .medium)
                    )
                )
                .padding([.leading])
            TextField(R.string.localizable.postName(), text: $viewData.postName)
                .modifier(ElevatedTextFieldModifier())
        }
        .padding([.leading, .trailing])
        .disabled(true)
    }
}

struct SharedProfileEmployeeView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        StatefulPreviewWrapper(SharedEmployeeViewData(
            userFIO: "",
            genderType: GenderEnum.none.rawValue,
            emailText: "",
            passwordText: "password",
            acccountStatus: "",
            userRole: "",
            confirmPasswordText: "password",
            contractNumber: "",
            postRole: "",
            postName: ""
        )) { binding in
            SharedProfileEmployeeView(
                viewData: binding
            )
        }
    }
}


