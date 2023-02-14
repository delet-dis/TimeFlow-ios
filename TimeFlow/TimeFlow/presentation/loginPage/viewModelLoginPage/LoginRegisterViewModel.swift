//
//  LoginRegisterViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 14.02.2023.
//

import Foundation

class LoginRegisterViewModel: ObservableObject{
    @Published var loginText = ""
    @Published var passwordText = ""
    private let condition: Condition
    
    init(condition: Condition) {
        self.condition = condition
    }
    
   
    
    
    var logInButton:String {
        switch condition{
        case .logIn:
            return "Войти"
        case .signUp:
            return "Зарегистрироваться"
        }
    }
    
    
}

extension LoginRegisterViewModel{
    
    enum Condition {
        case logIn
        case signUp
    }
    
}


