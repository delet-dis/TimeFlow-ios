//
//  SplashView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 03.03.2023.
//

import Lottie
import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()

            LottieView(name: "LoadingAnimation")

            Spacer()
        }
        .background(Color(uiColor: R.color.nearbyWhite() ?? .white))
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
