//
//  StateReducer.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
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
