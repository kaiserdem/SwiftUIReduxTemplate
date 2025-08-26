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
    
    let appliocation: ApplicationState
    var email: String = ""
    var isLoggedIn: Bool = false
    var isLoading: Bool = false
    var isValidEmail: Bool = false
    
    static let inital = State(appliocation: ApplicationState.inactive)
    
    static func stateReduce(into state: inout LoginState, action: any Action) {
        switch action {
        case let action as LoginActions.EmailChaged:
            state.email = action.email
            
        case is LoginActions.SetLogin:
            state.isLoading = true
            
        case let action as LoginActions.CompletionLogin:
            state.isLoading = false
            
            switch action.result {
            case .success(let token):
                print("Success, need save token: \(token)")
                state.isLoggedIn  = true
                
            case .failure(let error):
                print("Error, \(error.localizedDescription)")
                state.isLoggedIn = false
            }
            
            
        case let action as LoginActions.CheckValidation:
            state.isValidEmail = action.isValidEmail            
        default:
            break
        }
    }
    
    
}
