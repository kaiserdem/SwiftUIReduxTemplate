//
//  DebugLogMiddleware.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore
import os.log

public struct DebugLogMiddleware<AppState> {
    public init() {}
    
    public func middleware() -> Middleware<AppState> {
        { _, action, _, _ in
            // Log all actions except frequent ones to avoid spam
            // Логуємо всі дії окрім частих, щоб уникнути спаму
            os_log("%@",
                   log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Redux"),
                   type: .debug,
                   "✳️ \(String(reflecting: action).prefix(500))")
        }
    }
}
