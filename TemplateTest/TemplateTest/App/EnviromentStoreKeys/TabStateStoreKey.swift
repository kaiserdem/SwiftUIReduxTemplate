//
//  TabStateStoreKey.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import SwiftUI
import ReduxCore

enum TabStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<TabState>? = nil
}

extension EnvironmentValues {
    var tabStateStore: ObservableStore<TabState>? {
        get { self[TabStateStoreKey.self] }
        set { self[TabStateStoreKey.self] = newValue }
    }
}

