//
//  ApplicationState.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore


public enum ApplicationLifecycleActions {
    
    public struct DidBecomeActive: Action {}
    public struct WillResignActive: Action {}
    public struct DidEnterBackground: Action {}
    public struct WillEnterForeground: Action {}
}

public enum ApplicationState: Equatable {
    case active
    case inactive
    case background
    
    public static let initial = ApplicationState.active
}

extension ApplicationState: StateReducer {
    static func stateReduce(into state: inout ApplicationState, action: any Action) {
        switch action {
        case is ApplicationLifecycleActions.DidBecomeActive:
            state = .active
        case is ApplicationLifecycleActions.DidEnterBackground:
            state = .background
        case is ApplicationLifecycleActions.WillResignActive:
            state = .inactive
        default:
            break
        }
    }
}
