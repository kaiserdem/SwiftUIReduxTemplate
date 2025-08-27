//
//  LoginMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore

struct LoginMiddleware {
    
    func middleware() -> Middleware<AppRouterState> {
        
        { dispatch, action, oldState, newState in
            
            switch action {
                
            case let action as LoginActions.EmailChanged:
                let isValidEmail = validateEmail(action.email)
                dispatch(LoginActions.ValidationResult(isValidEmail: isValidEmail))
                
            case is LoginActions.SetLogin:
                Task {
                    // Симуляція API виклику
                    try await Task.sleep(for: .seconds(2))
                    dispatch(LoginActions.CompletionLogin(result: .success("Token123")))
                }
                
            default:
                break
            }
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
