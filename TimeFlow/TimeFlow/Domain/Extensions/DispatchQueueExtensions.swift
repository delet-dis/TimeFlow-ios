//
//  DispatchQueueExtensions.swift
//  TimeFlow
//
//  Created by Igor Efimov on 18.02.2023.
//

import Foundation

extension DispatchQueue {
    enum DispatchQueueDelay: Double {
        case short = 0.2
        case normal = 0.5
    }

    static func runAsyncOnMainWithDelay(
        delay: DispatchQueueDelay = .normal,
        _ closure: @escaping @convention(block) () -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay.rawValue) {
            closure()
        }
    }

    static func runAsyncInBackgroundrunAsyncOnMainWithDelay(
        _ closure: @escaping @convention(block) () -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            closure()
        }
    }
}
