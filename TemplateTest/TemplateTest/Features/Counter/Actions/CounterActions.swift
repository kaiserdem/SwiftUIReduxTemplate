//
//  CounterActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

enum CounterActions {
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct AddSingleItem: Action {}    
    struct ClearItems: Action {}    
}
