//
//  HomeViewModel.swift
//  TimeFlow
//
//  Created by Igor Efimov on 02.03.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    
    private let getTokenUseCase: GetTokenUseCase
    
    init(
        getTokenUseCase: GetTokenUseCase
    
    ) {
        self.getTokenUseCase = getTokenUseCase
    }
    
}
