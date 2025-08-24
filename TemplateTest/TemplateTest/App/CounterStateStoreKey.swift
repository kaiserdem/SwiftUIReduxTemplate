//
//  CounterStateStoreKey.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore
import SwiftUI

struct CounterStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<CounterState>? = nil
}

extension EnvironmentValues {
    var counterStateStore: ObservableStore<CounterState>? {
        get { self[CounterStateStoreKey.self] }
        set { self[CounterStateStoreKey.self] = newValue }
    }
}
