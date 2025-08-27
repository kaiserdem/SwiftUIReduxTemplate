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
        
        { dispatch, action, oldValue, newValue in
            switch action {
                
            case let action as LoginActions.EmailChaged:
                dispatch(LoginActions.CheckValidation(isValidEmail: !action.email.isEmpty))
                
            case let action as LoginActions.SetLogin:
                                
                Task {
                    
                    do  {
                        let token = try await loginApiManager.login(action.loginData)
                        dispatch(LoginActions.CompletionLogin(result: .success(token ?? "")))

                    } catch {
                        dispatch(LoginActions.CompletionLogin(result: .failure(error)))
                        dispatch(LoginActions.ShowLoginError(showError: true))
                    }
                }
                
            default:
                break
            }
        }
    }
}
