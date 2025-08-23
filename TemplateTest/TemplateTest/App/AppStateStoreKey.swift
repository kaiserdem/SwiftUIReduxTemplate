//
//  AppStateStoreKey.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore
import SwiftUI

// Конкретний Environment Key для вашого AppState
struct AppStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<AppState>? = nil
}

extension EnvironmentValues {
    var appStateStore: ObservableStore<AppState>? {
        get { self[AppStateStoreKey.self] }
        set { self[AppStateStoreKey.self] = newValue }
    }
}
