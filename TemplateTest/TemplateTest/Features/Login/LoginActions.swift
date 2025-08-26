//
//  LoginActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore

enum LoginActions {
    struct EmailChaged: Action { let email: String }
    struct SetLogin: Action { }
    struct CompletionLogin: Action { let result: Result<String,Error> }
    struct CheckValidation: Action { let isValidEmail: Bool }

}
