//
//  APIMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//


import Foundation
import ReduxCore

struct APICounterMiddleware {
    func middleware() -> Middleware<AppRouterState> {
        { dispatch, action, oldState, newState in
            switch action {
            case is CounterActions.StartLoading:
                Task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000) 
                    
                    let number = oldState.tabbarState.counterState.items.count + 1
                    let items = ["Item \(number)"]
                    await MainActor.run {
                        dispatch(CounterActions.LoadingFinished(items: items))
                    }
                }
            default:
                break
            }
        }
    }
}
