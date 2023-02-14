//
//  LoginRegisterView.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 14.02.2023.
//

import SwiftUI

struct LoginRegisterView: View {
    @ObservedObject var viewModel: LoginRegisterViewModel
    
    var loginTextField: some View{
        TextField("Login", text: $viewModel.loginText)
            .modifier(TextFieldStyle())
    }
    
    var passwordTextField: some View{
        SecureField("Password", text: $viewModel.passwordText)
            .modifier(TextFieldStyle())
    }
    
    var buttonForLogIn: some View{
        Button(viewModel.logInButton){
            
        }.padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.red)
        .overlay(
            RoundedRectangle(
                cornerRadius: 16
            ).stroke(
                Color.red
            )
        
        )
        .padding(.horizontal, 15)

    }
    
    var buttonForRegister: some View{
        Button("Регистрация"){
            
        }.padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.blue)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.blue
                )
            
            )
            .padding(.horizontal, 15)
    }
    
    var body: some View {
        VStack{
            Text("Hey 😘")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
                .frame(height: 100)
            loginTextField
            passwordTextField
            Spacer()
            buttonForLogIn
            buttonForRegister
            
        }.padding()
    }
}

struct LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginRegisterView(viewModel: .init(condition: .logIn))
        }.environment(\.colorScheme, .dark)
        
    }
}
