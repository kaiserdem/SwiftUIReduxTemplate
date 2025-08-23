//
//  APIMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//


import Foundation
import ReduxCore

struct APIMiddleware {
    func middleware() -> Middleware<AppState> {
        { dispatch, action, oldState, newState in
            switch action {
            case is Actions.StartLoading:
                // Симуляція API виклику
                Task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 секунди
                    
                    let number = oldState.items.count + 1
                    let items = ["Item \(number)"]
                    await MainActor.run {
                        dispatch(Actions.LoadingFinished(items: items))
                    }
                }
            default:
                break
            }
        }
    }
}
