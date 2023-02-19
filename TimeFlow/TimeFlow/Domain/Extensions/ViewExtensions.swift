//
//  ViewExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 18.02.2023.
//

import Combine
import SwiftUI
import UIKit

protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },

            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

extension View {
    static func confrimCustomPickerStyle() {
        let defaultSize = CGSize(width: 20, height: 15)

        let tintColorImage = UIImage(color: UIColor(named: "PickedColor") ?? .blue, size: defaultSize)
        UISegmentedControl.appearance().setBackgroundImage(
            UIImage(color: .clear, size: defaultSize), for: .normal, barMetrics: .default
        )

        UISegmentedControl.appearance().setBackgroundImage(
            tintColorImage, for: .selected, barMetrics: .default
        )
        UISegmentedControl.appearance().setBackgroundImage(
            UIImage(color: UIColor(named: "PickedColor") ?? .blue.withAlphaComponent(0.2),
                    size: defaultSize),
            for: .highlighted, barMetrics: .default
        )
        UISegmentedControl.appearance().setBackgroundImage(
            tintColorImage, for: [.highlighted, .selected], barMetrics: .default
        )

        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
}
