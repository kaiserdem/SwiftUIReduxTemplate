//
//  State.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Main application state combining all sub-states
/// Використовує нову архітектуру з протоколом StateReducer
/// Головний стан додатку що об'єднує всі під-стани
/// Використовує нову архітектуру з протоколом StateReducer
struct AppState: StateReducer {
    typealias State = AppState
    
    // REQUIRED: Application lifecycle state (DO NOT REMOVE)
    // ОБОВ'ЯЗКОВО: Стан життєвого циклу додатку (НЕ ВИДАЛЯТИ)
    let application: ApplicationState
    
    // TODO: Add your custom states here
    // TODO: Додайте ваші кастомні стани тут
    
    /// Example: Loading state for API calls
    /// Приклад: Стан завантаження для API викликів
    var isLoading: Bool
    
    /// Example: Array of data from API
    /// Приклад: Масив даних з API
    var items: [String] // Replace with your data type
    
    /// Example: Error message
    /// Приклад: Повідомлення про помилку
    let errorMessage: String?
    
    static let initial = State(
        application: ApplicationState.initial,
        // TODO: Initialize your custom states
        // TODO: Ініціалізуйте ваші кастомні стани
        isLoading: false,
        items: [],
        errorMessage: nil
    )
    
    // MARK: - StateReducer Implementation
    // MARK: - Реалізація StateReducer
    
    /// Main reducer function using new architecture
    /// Головна функція reducer використовуючи нову архітектуру
    static func stateReduce(into state: inout AppState, action: any Action) {
        // Handle your custom actions
        // Обробіть ваші кастомні дії
        switch action {
        case is Actions.StartLoading:
            state.isLoading = true
            
        case let action as Actions.LoadingFinished:
            state.isLoading = false
            state.items = state.items + action.items
            
        case let action as Actions.AddSingleItem:
            state.items = state.items + [action.item]
            
        case is Actions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}

// MARK: - ApplicationState Extension (DO NOT MODIFY)
// MARK: - Extension для ApplicationState (НЕ ЗМІНЮВАТИ)

extension ApplicationState: StateReducer {
    static func stateReduce(into state: inout ApplicationState, action: any Action) {
        switch action {
        case is ApplicationLifecycleActions.DidBecomeActive:
            state = .active
        case is ApplicationLifecycleActions.DidEnterBackground:
            state = .background
        case is ApplicationLifecycleActions.WillResignActive:
            state = .inactive
        default:
            break
        }
    }
}
