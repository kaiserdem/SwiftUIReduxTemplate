//
//  AppRouterActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 26/08/2025.
//

import Foundation
import ReduxCore

enum AppRouterActions {
    struct SetLogin: Action { let isLoggedIn: Bool }
    struct NavigateToLogin: Action { }
    struct NavigateToTabBar: Action { }
}
