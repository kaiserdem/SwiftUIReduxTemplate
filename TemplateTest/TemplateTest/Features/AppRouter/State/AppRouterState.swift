//
//  AppRouterState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 26/08/2025.
//

import Foundation
import ReduxCore

struct AppRouterState: StateReducer {
    typealias State = AppRouterState
    
    var application: ApplicationState
    var isLoggedIn: Bool = false
    var loginState: LoginState
    var tabbarState: TabState
    
    static let initial = State(
        application: ApplicationState.initial,
        isLoggedIn: false,
        loginState: LoginState.initial,
        tabbarState: TabState.initial
    )
    
    static func stateReduce(into state: inout AppRouterState, action: any Action) {
        
        switch action {
        case let action as AppRouterActions.SetLogin:
            state.isLoggedIn = action.isLoggedIn
            
        case let action as LoginActions.CompletionLogin:
            switch action.result {
            case .success(let token):
                print("Login успішний: \(token)")
                state.isLoggedIn = true
                
            case .failure(let error):
                state.isLoggedIn = false
            }
            
        case let action as LoginActions.SetLogin:
            state.isLoggedIn = false
            
        case let action as LoginActions.EmailChanged:
            state.loginState = LoginState.reduce(state.loginState, with: action)
            
        case let action as LoginActions.ValidationResult:
            state.loginState = LoginState.reduce(state.loginState, with: action)
            
        case is ApplicationLifecycleActions.DidBecomeActive:
            state.application = .active
            
        case is ApplicationLifecycleActions.DidEnterBackground:
            state.application = .background
            
        case is ApplicationLifecycleActions.WillResignActive:
            state.application = .inactive
            
        default:
            state.loginState = LoginState.reduce(state.loginState, with: action)
            state.tabbarState = TabState.reduce(state.tabbarState, with: action)
            state.application = ApplicationState.reduce(state.application, with: action)
        }        
    }
}
