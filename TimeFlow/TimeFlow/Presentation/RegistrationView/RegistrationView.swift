//
//  RegistrationView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 17.02.2023.
//

import AxisSegmentedView
import Foundation
import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var viewModel: RegistrationViewModel
    @State private(set) var viewDisplayingMode = RegistrationViewDisplayingModeEnum.teacher
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(R.string.localizable.helloRegister())
                    .font(
                        Font(R.font.ralewayBold(size: 30) ?? .systemFont(ofSize: 30, weight: .medium))
                    ).padding(.horizontal, 20)
                
                Spacer()
            }
            ZStack {
                AxisSegmentedView(selection: $viewModel.viewDisplayingModeIndex) {
                    ForEach(RegistrationViewDisplayingModeEnum.allCases) { role in
                        Text(role.savedValue)
                            .itemTag(role.rawValue)
                    }
                }
            style: {
                    ASCapsuleStyle(
                        backgroundColor: .white,
                        foregroundColor: .init(uiColor: R.color.lightYellow() ?? .yellow),
                        movementMode: .normal
                    )
                }
            onTapReceive: { selectionTap in
                    print(selectionTap)
                
                    for role in RegistrationViewDisplayingModeEnum.allCases {
                        if selectionTap == role.rawValue {
                            viewModel.changeRole(role: role)
                            print(viewModel.viewDisplayingMode)
                        }
                    }
                   
                }.background {
                    RoundedRectangle(cornerRadius: 90).foregroundColor(.black)
                }
            }
            .padding(.bottom, 650)
            .padding(.horizontal, 10)
            ZStack {
                viewModel.registrationComponent?.studentRegistrationView
                Group {
                    switch viewDisplayingMode {
                    case .teacher:
                        viewModel.registrationComponent?.teacherRegistrationView

                    case .student:
                        viewModel.registrationComponent?.studentRegistrationView
                    case .externalUser:
                        viewModel.registrationComponent?.externalUserRegistrationView
                    }
                }
            }
            .padding(.horizontal, 24)
        }.onChange(of: viewModel.viewDisplayingMode) { newValue in
            withAnimation {
                viewDisplayingMode = newValue
            }
        }
    }
    
    struct RegistrationView_Preview: PreviewProvider {
        private static let mainComponent = MainComponent()
        
        static var previews: some View {
            RegistrationView()
                .environmentObject(mainComponent.registrationComponent.registrationViewModel)
        }
    }
}
