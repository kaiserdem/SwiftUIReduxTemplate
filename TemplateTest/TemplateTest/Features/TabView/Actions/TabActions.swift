//
//  TabActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore

enum TabActions {
    struct SelectedTab: Action { let tab: Tab }
    struct CounterAction: Action { }
    struct ImageAction: Action { }
}
