//
//  StateReducer.swift
//  SwiftUIRedux
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

/// Protocol for Redux state management with new architecture
/// Протокол для управління Redux станом з новою архітектурою
public protocol StateReducer {
    associatedtype State
    
    /// Reduce function that modifies state directly (new approach)
    /// Функція reducer що змінює стан напряму (новий підхід)
    static func stateReduce(into state: inout State, action: any Action)
}

// MARK: - Automatic Composition Extension
// MARK: - Extension для автоматичної композиції

/// Automatic composition of reducers using functional approach
/// Автоматична композиція reducer'ів використовуючи функціональний підхід
public extension StateReducer where Self == State {
    
    /// Functional reducer that automatically composes with stateReduce
    /// Функціональний reducer що автоматично компонується з stateReduce
    static func reduce(_ state: State, with action: any Action) -> State {
        var newState = state
        
        // Automatically call stateReduce for composition
        // Автоматично викликаємо stateReduce для композиції
        stateReduce(into: &newState, action: action)
        
        return newState
    }
}
