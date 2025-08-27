//
//  LoginState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore

struct LoginState: StateReducer {
    typealias State = LoginState
    
    var email: String = ""
    var isLoading: Bool = false
    var isValidEmail: Bool = false
    
    static let initial = LoginState()
    
    static func stateReduce(into state: inout LoginState, action: any Action) {
        switch action {
        case let action as LoginActions.EmailChanged:
            state.email = action.email
            
        case is LoginActions.SetLogin:
            state.isLoading = true
            
        case let action as LoginActions.CompletionLogin:
            state.isLoading = false
            
        case let action as LoginActions.ValidationResult:
            state.isValidEmail = action.isValidEmail
            
        default:
            break
        }
    }
}
