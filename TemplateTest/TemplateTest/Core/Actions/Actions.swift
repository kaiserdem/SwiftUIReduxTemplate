//
//  Actions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

enum Actions {
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct AddSingleItem: Action { let item: String }    
    struct ClearItems: Action {}    
}
