//
//  LoaderView.swift
//  TimeFlow
//
//  Created by Igor Efimov on 03.03.2023.
//

import Foundation
import SwiftUI

final class LoaderView {
    static func startLoading(text: String = R.string.localizable.loading()) {
        DispatchQueue.main.async {
            SwiftLoader.show(title: text, animated: true)
        }
    }

    static func endLoading() {
        DispatchQueue.main.async {
            SwiftLoader.hide()
        }
    }
}
