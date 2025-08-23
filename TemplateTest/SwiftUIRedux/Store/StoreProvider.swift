//
//  StoreProvider.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import SwiftUI
import ReduxCore
import Foundation

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
    public func dispatch(command: Command) {
        command.perform()
    }
    
    /// Dispatch command with parameters
    public func dispatch<T>(command: CommandWith<T>, with value: T) {
        command.perform(with: value)
    }
    
    deinit {
        cancellation?.cancel()
    }
}

public struct AppStoreKey<State>: EnvironmentKey {
    public static var defaultValue: ObservableStore<State>? { nil }
}

public extension EnvironmentValues {

    func appStore<State>() -> ObservableStore<State>? {
        return self[AppStoreKey<State>.self]
    }
    
    mutating func setAppStore<State>(_ store: ObservableStore<State>) {
        self[AppStoreKey<State>.self] = store
    }
}
