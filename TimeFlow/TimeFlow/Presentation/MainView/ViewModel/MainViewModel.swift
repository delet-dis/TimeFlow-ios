//
//  MainViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 14.02.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    private(set) var authorizationComponent: AuthorizationComponent?

    init(authorizationComponent: AuthorizationComponent? = nil) {
        self.authorizationComponent = authorizationComponent
    }
}
