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
    struct SetLogin: Action { let loginData: String }
    struct CompletionLogin: Action { let result: Result<String,Error> }
    struct ShowLoginError: Action { let showError: Bool }
    struct CheckValidation: Action { let isValidEmail: Bool }

}
