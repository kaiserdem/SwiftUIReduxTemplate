//
//  Actions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import Foundation
import ReduxCore

enum Actions {
    // Лічильник
    struct IncrementCounter: Action {}
    struct DecrementCounter: Action {}
    
    // Завантаження даних
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    
    struct AddSingleItem: Action { let item: String }    
    struct ClearItems: Action {}
    
    // Помилки
    struct ShowError: Action { let message: String }
    struct ClearError: Action {}
}
