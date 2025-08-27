//
//  LoginActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import Foundation
import ReduxCore

enum LoginActions {
    struct EmailChanged: Action { let email: String }
    struct SetLogin: Action { }
    struct CompletionLogin: Action { let result: Result<String, Error> }
    struct ValidationResult: Action { let isValidEmail: Bool }
}
