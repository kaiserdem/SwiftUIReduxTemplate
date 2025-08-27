//
//  AppRouterStateKey .swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 26/08/2025.
//

import Foundation
import ReduxCore
import SwiftUI

enum AppRouterStateKey: EnvironmentKey {
    static var defaultValue: ObservableStore<AppRouterState>? = nil
}

extension EnvironmentValues {
    var appRouterStateStore: ObservableStore<AppRouterState>? {
        get { self[AppRouterStateKey.self] }
        set { self[AppRouterStateKey.self] = newValue }
    }
}
