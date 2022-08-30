//
//  LoginViewModel.swift
//  AIMeng
//
//  Created by Iryna Piskorska 
//

import Foundation
import FirebaseAuth

protocol LoginViewModelViewDelegate: AnyObject {
    func didFailedLogin(error: String)
}

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func navigateToProjectsList(vievModeL: LoginViewModel)
}

class LoginViewModel {
    
    enum Constant {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    weak var viewDelegate: LoginViewModelViewDelegate?
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    
    func validateEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", Constant.emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        guard password.isEmpty else { return true }
        return false
    }
    
    func firebaseAuth(email: String, password: String) {
        
        guard validateEmail(email) else {
            viewDelegate?.didFailedLogin(error: "Please enter valid e-mail")
            return
        }
        
        guard validatePassword(password) else {
            viewDelegate?.didFailedLogin(error: "Please enter password")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                self.viewDelegate?.didFailedLogin(error: error.localizedDescription)
            } else if let result = result {
                self.coordinatorDelegate?.navigateToProjectsList(vievModeL: self)
            }
        })
    }
    
    func biometricsAuth() {
        self.coordinatorDelegate?.navigateToProjectsList(vievModeL: self)
    }
}
