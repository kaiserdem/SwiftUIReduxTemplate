//
//  StoreProvider.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore
import Foundation

/// ObservableStore for SwiftUI integration
/// Replaces the StoreLocator pattern with Environment-based injection
/// ObservableStore для інтеграції з SwiftUI
/// Замінює паттерн StoreLocator на інжекцію через Environment
@Observable
public final class ObservableStore<State> {
    public private(set) var state: State
    private let store: Store<State>
    private var cancellation: Cancellation?
    
    public init(store: Store<State>) {
        self.store = store
        self.state = store.state
        self.cancellation = store.observe { [weak self] state in
            Foundation.DispatchQueue.main.async {
                self?.state = state
            }
        }
    }
    
    public func dispatch(action: any ReduxCore.Action) {
        store.dispatch(action: action)
    }
    
    /// Dispatch command without parameters
    /// Відправка команди без параметрів
    public func dispatch(command: Command) {
        command.perform()
    }
    
    /// Dispatch command with parameters
    /// Відправка команди з параметрами
    public func dispatch<T>(command: CommandWith<T>, with value: T) {
        command.perform(with: value)
    }
    
    deinit {
        cancellation?.cancel()
    }
}

// MARK: - Environment for global state access
// MARK: - Environment для глобального доступу до стану

/// Environment key for the app store
/// Ключ Environment для app store
public struct AppStoreKey<State>: EnvironmentKey {
    public static var defaultValue: ObservableStore<State>? { nil }
}

public extension EnvironmentValues {
    /// Generic store access through Environment
    /// Загальний доступ до store через Environment
    func appStore<State>() -> ObservableStore<State>? {
        return self[AppStoreKey<State>.self]
    }
    
    /// Set store in Environment
    /// Встановити store в Environment
    mutating func setAppStore<State>(_ store: ObservableStore<State>) {
        self[AppStoreKey<State>.self] = store
    }
}
