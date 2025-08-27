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
    var loginState: LoginState.State = .inital
    var tabbarState: TabState.State = .inital
    
    static let inital = State(application: ApplicationState.initial,
                              isLoggedIn: false,
                              loginState: LoginState.inital,
                              tabbarState: TabState.inital)
    
    static func stateReduce(into state: inout AppRouterState, action: any Action) {
        print("🔍 AppRouterState.stateReduce викликано з action: \(type(of: action))")
        print("🔍 Action type: \(type(of: action))")

        
        switch action {
        case let action as AppRouterActions.SetLogin:
            print("🔍 AppRouterActions.SetLogin спрацював")
            state.isLoggedIn = action.isLoggedIn
            
            
            /*
             case is CounterActions.StartLoading:
                 state.counterState = CounterState.reduce(state.counterState, with: action)
             */
           
        case is LoginActions.CompletionLogin:
            state.loginState = LoginState.reduce(state.loginState, with: action)
//        case let action as LoginActions.CompletionLogin:
//            print("🔍 LoginActions.CompletionLogin спрацював")
//            switch action.result {
//            case .success(let token):
//                print("�� Login успішний: \(token)")
//                state.isLoggedIn = true
//                
//            case .failure(let error):
//                print("�� Login невдалий: \(error)")
//                state.isLoggedIn = false
//            }
            
        case let action as LoginActions.SetLogin:
            print("🔍 LoginActions.SetLogin спрацював")
            state.isLoggedIn = false
            
        case let action as LoginActions.EmailChaged:
            print("�� LoginActions.EmailChanged спрацював")
            state.loginState = LoginState.reduce(state.loginState, with: action)
            
        case let action as LoginActions.CheckValidation:
            print("🔍 LoginActions.ValidationResult спрацював")
            state.loginState = LoginState.reduce(state.loginState, with: action)
            
        
        case is ApplicationLifecycleActions.DidBecomeActive:
            state.application = .active
            
        case is ApplicationLifecycleActions.DidEnterBackground:
            state.application = .background
            
        case is ApplicationLifecycleActions.WillResignActive:
            state.application = .inactive
            
        default:
            print("🔍 AppRouterState: default case для \(type(of: action))")
            // ✅ Передаємо дії до під-станів
            state.loginState = LoginState.reduce(state.loginState, with: action)
            state.tabbarState = TabState.reduce(state.tabbarState, with: action)
            state.application = ApplicationState.reduce(state.application, with: action)
        }
    }
    
    
}
/*
 struct TabState: StateReducer {
     typealias State = TabState
     
     var application: ApplicationState
     var selectedTab: Tab = .image
     var counterState: CounterState.State = .initial
     var imageState: ImageState.State = .inital
     
     static let inital = State(application: ApplicationState.initial,
                               selectedTab: .image,
                               counterState: CounterState.initial,
                               imageState: ImageState.inital)

     static func stateReduce(into state: inout TabState, action: any Action) {
         
         switch action {
         case let action as TabActions.SelectedTab:
             state.selectedTab = action.tab
             
         case is CounterActions.StartLoading:
             state.counterState = CounterState.reduce(state.counterState, with: action)
             
         case is CounterActions.LoadingFinished:
             state.counterState = CounterState.reduce(state.counterState, with: action)
             
         case is CounterActions.AddSingleItem:
             state.counterState = CounterState.reduce(state.counterState, with: action)
             
         case is CounterActions.ClearItems:
             state.counterState = CounterState.reduce(state.counterState, with: action)
             
         case is ImageActions.DownloadImage:
             state.imageState = ImageState.reduce(state.imageState, with: action)
             
         case is ImageActions.CompletionImage:
             state.imageState = ImageState.reduce(state.imageState, with: action)
             
         case is ImageActions.ErrorDownloadImage:
             state.imageState = ImageState.reduce(state.imageState, with: action)
             
         case is ApplicationLifecycleActions.DidBecomeActive:
             state.application = .active
             
         case is ApplicationLifecycleActions.DidEnterBackground:
             state.application = .background
             
         case is ApplicationLifecycleActions.WillResignActive:
             state.application = .inactive
             
         default:
             print("Невідомий action: \(type(of: action))")
             break
         }
     }
 */
