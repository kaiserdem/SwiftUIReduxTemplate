//
//  AppState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

struct AppState {
    let application: ApplicationState
    let isLoading: Bool
    let items: [String]
    let errorMessage: String?
    
    static let initial = AppState(
        application: ApplicationState.initial,
        isLoading: false,
        items: [],
        errorMessage: nil
    )
}


func reduce(_ state: AppState, with action: Action) -> AppState {
    var newState = state
    
    // Application lifecycle (обов'язково!)
    newState = AppState(
        application: reduce(state.application, with: action),
        isLoading: state.isLoading,
        items: state.items,
        errorMessage: state.errorMessage
    )
    
    // Обробка наших дій
        switch action {
        case is Actions.StartLoading:
            return AppState(
                application: newState.application,
                isLoading: true,
                items: state.items,
                errorMessage: nil
            )
            
        case let action as Actions.LoadingFinished:
                return AppState(
                    application: newState.application,
                    isLoading: false,
                    items: state.items + action.items,
                    errorMessage: nil
                )
            
        case let action as Actions.AddSingleItem:
                return AppState(
                    application: newState.application,
                    isLoading: state.isLoading,
                    items: state.items + [action.item],
                    errorMessage: nil
                )
                
            case is Actions.ClearItems:
                return AppState(
                    application: newState.application,
                    isLoading: state.isLoading,
                    items: [],       
                    errorMessage: nil
                )
            
        default:
            return newState
        }
    
}
