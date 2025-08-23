//
//  CustomMiddleware.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Example middleware for handling API calls
/// Використовує нову архітектуру з протоколом StateReducer
/// Приклад middleware для обробки API викликів
/// Використовує нову архітектуру з протоколом StateReducer
struct APIMiddleware {
    
    /// Create middleware instance
    /// Створити екземпляр middleware
    func middleware() -> Middleware<AppState> {
        return { dispatch, action, oldState, newState in
            
            // TODO: Handle your custom actions
            // TODO: Обробіть ваші кастомні дії
            switch action {
            case is Actions.StartLoading:
                print("🔄 Starting API call...")
                
                // Simulate API call
                // Симуляція API виклику
                DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                    // Simulate success
                    // Симуляція успіху
                    let mockData = ["Item 1", "Item 2", "Item 3"]
                    DispatchQueue.main.async {
                        dispatch(Actions.LoadingFinished(items: mockData))
                    }
                }
                
            case let action as Actions.LoadingFinished:
                print("✅ API call successful: \(action.items)")
                
            case let action as Actions.AddSingleItem:
                print("➕ Adding item: \(action.item)")
                
            case is Actions.ClearItems:
                print("🗑️ Clearing all items")
                
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
            case is Actions.StartLoading:
                print("👆 User started loading data")
                
            case let action as Actions.AddSingleItem:
                print("👆 User added item: \(action.item)")
                
            case is Actions.ClearItems:
                print("👆 User cleared all items")
                
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
         reducer: AppState.reduce,  // ✅ Нова архітектура
         middlewares: [
             DebugLogMiddleware<AppState>().middleware(),  // From ReduxCore
             APIMiddleware().middleware(),                 // Your custom middleware
             UserActionMiddleware().middleware()           // Your custom middleware
         ]
     )
 )
 */
