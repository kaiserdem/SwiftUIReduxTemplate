//
//  CounterState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

struct CounterState: StateReducer {
    typealias State = CounterState
    
    var isLoading: Bool
    var items: [String]
    
    static let initial = State(
        isLoading: false,
        items: []
    )
    
    static func stateReduce(into state: inout CounterState, action: any Action) {
        switch action {
        case is CounterActions.StartLoading:
            state.isLoading = true
            
        case let action as CounterActions.LoadingFinished:
            state.isLoading = false
            state.items = state.items + action.items
            
        case _ as CounterActions.AddSingleItem:
            let newItem = "Item \(state.items.count + 1)"
            state.items = state.items + [newItem]
            
        case is CounterActions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}

