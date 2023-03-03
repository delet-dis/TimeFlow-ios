//
//  LottieView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 03.03.2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var loopMode: LottieLoopMode = .loop

    var animationView: LottieAnimationView

    init(name: String) {
        self.animationView = .init(name: name)
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
