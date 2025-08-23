//
//  AppState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

protocol StateReducer {
    associatedtype State
    
    static func stateReduce(into state: inout State, action: any Action)
}

extension StateReducer where Self == State {
    static func reduce(_ state: State, with action: any Action) -> State {
        var newState = state
        
        stateReduce(into: &newState, action: action)
        
        return newState
    }
}

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
            
        case let action as Actions.AddSingleItem:
            state.items = state.items + [action.item]
            
        case is Actions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}

