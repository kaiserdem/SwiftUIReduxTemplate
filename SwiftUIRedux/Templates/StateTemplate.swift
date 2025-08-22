//
//  State.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Main application state combining all sub-states
/// Головний стан додатку що об'єднує всі під-стани
struct AppState {
    // REQUIRED: Application lifecycle state (DO NOT REMOVE)
    // ОБОВ'ЯЗКОВО: Стан життєвого циклу додатку (НЕ ВИДАЛЯТИ)
    let application: ApplicationState
    
    // TODO: Add your custom states here
    // TODO: Додайте ваші кастомні стани тут
    
    /// Example: Loading state for API calls
    /// Приклад: Стан завантаження для API викликів
    let isLoading: Bool
    
    /// Example: Array of data from API
    /// Приклад: Масив даних з API
    let items: [String] // Replace with your data type
    
    /// Example: Error message
    /// Приклад: Повідомлення про помилку
    let errorMessage: String?
    
    static let initial = AppState(
        application: ApplicationState.initial,
        // TODO: Initialize your custom states
        // TODO: Ініціалізуйте ваші кастомні стани
        isLoading: false,
        items: [],
        errorMessage: nil
    )
}

/// Main app reducer combining all sub-reducers
/// Головний reducer додатку що об'єднує всі під-reducers
func reduce(_ state: AppState, with action: Action) -> AppState {
    var newState = state
    
    // Handle application lifecycle (DO NOT MODIFY)
    // Обробка життєвого циклу додатку (НЕ ЗМІНЮВАТИ)
    newState = AppState(
        application: reduce(state.application, with: action),
        isLoading: state.isLoading,
        items: state.items,
        errorMessage: state.errorMessage
    )
    
    // TODO: Handle your custom actions
    // TODO: Обробіть ваші кастомні дії
    switch action {
    case is Actions.API.StartLoading:
        return AppState(
            application: newState.application,
            isLoading: true,
            items: state.items,
            errorMessage: nil
        )
        
    case let action as Actions.API.LoadSuccess:
        return AppState(
            application: newState.application,
            isLoading: false,
            items: action.data,
            errorMessage: nil
        )
        
    case let action as Actions.API.LoadFailure:
        return AppState(
            application: newState.application,
            isLoading: false,
            items: state.items,
            errorMessage: action.error.localizedDescription
        )
        
    default:
        return newState
    }
}
