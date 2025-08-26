//
//  LoginMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore

struct LoginMiddleware {
    
    func middleware() -> Middleware<LoginState> {
        
        { dispatch, action, oldValue, newValue in
            switch action {
                
            case let action as LoginActions.EmailChaged:
                dispatch(LoginActions.CheckValidation(isValidEmail: !action.email.isEmpty))
                
            case is LoginActions.SetLogin:
                                
                Task {
                    try await Task.sleep(for: .seconds(2))                    
                    dispatch(LoginActions.CompletionLogin(result: .success("Token")))
                }
                
            default:
                break
            }
        }
    }
}
