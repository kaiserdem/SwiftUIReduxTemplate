//
//  AppState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

struct AppState: StateReducer {
    typealias State = AppState
    
    let application: ApplicationState
    var isLoading: Bool
    var items: [String]
    let errorMessage: String?
    
    static let initial = State(
        application: ApplicationState.initial,
        isLoading: false,
        items: [],
        errorMessage: nil
    )
    
    static func stateReduce(into state: inout AppState, action: any Action) {
        switch action {
        case is Actions.StartLoading:
            state.isLoading = true
            
        case let action as Actions.LoadingFinished:
            state.isLoading = false
            state.items = state.items + action.items
            
        case _ as Actions.AddSingleItem:
            let newItem = "Item \(state.items.count + 1)"
            state.items = state.items + [newItem]
            
        case is Actions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}

