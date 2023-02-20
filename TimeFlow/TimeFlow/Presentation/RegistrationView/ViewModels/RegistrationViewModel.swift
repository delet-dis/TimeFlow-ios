//
//  RegistrationViewModel.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 19.02.2023.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    let registrationComponent: RegistrationComponent?
    private(set) var setStudentRegistrationViewClousure: (() -> Void)?
    private(set) var setTeacherRegistrationViewClousure: (() -> Void)?
    private(set) var setExternalUserRegistrationViewClousure: (() -> Void)?
    
    init(
        registrationComponent: RegistrationComponent? = nil
       
    ) {
        self.registrationComponent = registrationComponent
    }
    
    func pressStudentRegistrationViewClousure(_ studentRegistrationViewClosure: (() -> Void)? = nil) {
        setStudentRegistrationViewClousure = studentRegistrationViewClosure
    }
    
    func pressTeacherRegistrationViewClousure(_ teacherRegistrationViewClousure: (() -> Void)? = nil) {
        setTeacherRegistrationViewClousure = teacherRegistrationViewClousure
    }
    
    func pressExternalUserRegistrationViewClousure(_ externalUserRegistrationViewClousure: (() -> Void)? = nil) {
        setExternalUserRegistrationViewClousure = externalUserRegistrationViewClousure
    }
}
