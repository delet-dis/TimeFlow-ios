//
//  SharedTeacherFormView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 24.02.2023.
//

import Foundation
import SwiftUI

struct SharedTeacherFormView: View {
    @Binding var viewData: SharedTeacherViewData
    @Binding var viewTeacherState: SharedTeacherViewState

    var body: some View {
        VStack {
            Text(R.string.localizable.employeeContract)
                .font(
                    Font(R.font.ralewayBold(size: 24) ??
                        .systemFont(ofSize: 24, weight: .medium))
                )
            TextField(R.string.localizable.contractNumber(),
                      text: $viewData.contractNumber)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .modifier(ElevatedTextField())
        }
        .padding(.horizontal, 20)
    }
}

struct SharedTeacherFormView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(SharedTeacherViewData(contractNumber: "")
        ) { binding in
            SharedTeacherFormView(viewData: binding, viewTeacherState: .constant(SharedTeacherViewState(isContractNumber: true)))
        }
    }
}
