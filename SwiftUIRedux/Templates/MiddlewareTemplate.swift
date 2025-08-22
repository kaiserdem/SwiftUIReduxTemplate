//
//  CustomMiddleware.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Example middleware for handling API calls
/// Приклад middleware для обробки API викликів
struct APIMiddleware {
    
    /// Create middleware instance
    /// Створити екземпляр middleware
    func middleware() -> Middleware<AppState> {
        return { dispatch, action, oldState, newState in
            
            // TODO: Handle your custom actions
            // TODO: Обробіть ваші кастомні дії
            switch action {
            case is Actions.MainScreen.ButtonTapped:
                // Example: When button tapped, start loading
                // Приклад: Коли кнопку натиснуто, почати завантаження
                dispatch(Actions.API.StartLoading())
                
                // Simulate API call
                // Симуляція API виклику
                DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                    // Simulate success
                    // Симуляція успіху
                    let mockData = ["Item 1", "Item 2", "Item 3"]
                    DispatchQueue.main.async {
                        dispatch(Actions.API.LoadSuccess(data: mockData))
                    }
                }
                
            case is Actions.API.StartLoading:
                print("🔄 Starting API call...")
                
            case let action as Actions.API.LoadSuccess:
                print("✅ API call successful: \(action.data)")
                
            case let action as Actions.API.LoadFailure:
                print("❌ API call failed: \(action.error)")
                
            default:
                // Do nothing for other actions
                // Нічого не робити для інших дій
                break
            }
        }
    }
}

/// Example middleware for logging user actions
/// Приклад middleware для логування дій користувача
struct UserActionMiddleware {
    
    func middleware() -> Middleware<AppState> {
        return { dispatch, action, oldState, newState in
            
            // Log user interactions
            // Логування взаємодій користувача
            switch action {
            case let action as Actions.MainScreen.ButtonTapped:
                print("👆 User tapped button: \(action.buttonType)")
                
                // TODO: Send analytics event
                // TODO: Відправити аналітичну подію
                // Analytics.track("button_tapped", properties: ["type": action.buttonType])
                
            default:
                break
            }
        }
    }
}

// MARK: - Usage Example
// MARK: - Приклад використання

/*
 How to use these middlewares in your App.swift:
 Як використовувати ці middleware в вашому App.swift:
 
 private let store = ObservableStore<AppState>(
     store: Store<AppState>(
         state: AppState.initial,
         reducer: reduce,
         middlewares: [
             DebugLogMiddleware().middleware(),  // From ReduxCore
             APIMiddleware().middleware(),       // Your custom middleware
             UserActionMiddleware().middleware() // Your custom middleware
         ]
     )
 )
 */
