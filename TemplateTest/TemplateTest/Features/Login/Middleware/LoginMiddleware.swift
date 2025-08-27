//
//  LoginMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore
import Dependencies

struct LoginMiddleware {
    
    @Dependency(\.loginApiManager) var loginApiManager
    
    func middleware() -> Middleware<AppRouterState> {
        
        { dispatch, action, oldState, newState in
            switch action {
                
            case let action as LoginActions.EmailChanged:
                let isValidEmail = validateEmail(action.email)
                dispatch(LoginActions.ValidationResult(isValidEmail: isValidEmail))
                
            case is LoginActions.SetLogin:
                Task {
                    
                    do {
                        let token = try await loginApiManager.login(oldState.loginState.email)
                        dispatch(LoginActions.CompletionLogin(result: .success(token)))
                    } catch {
                        dispatch(LoginActions.CompletionLogin(result: .failure(error)))
                    }
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
