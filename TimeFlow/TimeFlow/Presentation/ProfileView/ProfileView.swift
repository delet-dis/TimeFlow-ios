//
//  ProfileView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 07.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var motionManager = MotionManager()
    @State private var isLogoTopLocated = true
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.mainWindowSize) var mainWindowSize
    
    var body: some View {
        VStack {
            HStack {
                switch viewModel.userRole {
                case .user:
                    Text(R.string.localizable.profile() + " " + R.string.localizable.externalUser())
                case .employee:
                    Text(R.string.localizable.profile() + " " + R.string.localizable.teacher())
                       
                case .student:
                    Text(R.string.localizable.profile() + " " + R.string.localizable.student())
        
                case .none:
                    Text("Problems")
                }
            }
            .font(
                Font(R.font.ralewayMedium(size: 30) ?? .systemFont(ofSize: 30, weight: .medium))
            )
           
            Spacer()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    SharedProfileView(
                        viewData: $viewModel.sharedExternalUserProfileData
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 25)
                }
                VStack {
                    Spacer()
                    
                    Button {
                        viewModel.logout()
                    } label: {
                        HStack {
                            Text(R.string.localizable.logOut())
                                .font(
                                    Font(
                                        R.font.ralewayMedium(size: 15) ??
                                            .systemFont(ofSize: 15, weight: .medium)
                                    )
                                )
                        }
                    }
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(
                                Color(uiColor: R.color.lightYellow() ?? .yellow)
                            )
                    }
                    .shadow(color: Color(uiColor: R.color.lightYellow() ?? .yellow), radius: 20, x: 0, y: 0)
                }
            }
        }
        
        .background(
            VStack {
                HStack {
                    Spacer()

                    Image(uiImage: R.image.appIconCopy() ?? .strokedCheckmark)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(30)
                        .blur(radius: 6)
                        .rotationEffect(isLogoTopLocated ? .degrees(-30) : .degrees(-250))
                        .offset(
                            x: isLogoTopLocated ? 0 : -mainWindowSize.width / 2,
                            y: isLogoTopLocated ? 0 : mainWindowSize.height / 2
                        )
                }

                Spacer()
            }
            .ignoresSafeArea()
            .modifier(ParallaxMotionModifier(manager: motionManager, magnitude: 30))
        )

        .onAppear {
            viewModel.viewDidAppear()
            viewModel.getExternalUserProfileData()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        ProfileView(viewModel: mainComponent.profileComponent.profileViewModel)
    }
}
