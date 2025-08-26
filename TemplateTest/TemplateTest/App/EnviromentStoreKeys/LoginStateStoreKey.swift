//
//  LoginStateStoreKey.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import SwiftUI

enum LoginStateStoreKey: EnvironmentKey {
    static let defaultValue: ObservableStore<LoginState>? = nil
}

extension EnvironmentValues {
    var loginStateStore: ObservableStore<LoginState>? {
        get { self[LoginStateStoreKey.self] }
        set { self[LoginStateStoreKey.self] = newValue }
    }
}
