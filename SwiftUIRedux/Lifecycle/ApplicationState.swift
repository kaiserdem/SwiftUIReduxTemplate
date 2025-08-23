//
//  ApplicationState.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore

// MARK: - Application Lifecycle Actions
// MARK: - Дії життєвого циклу додатку

/// Actions triggered by app lifecycle events (from ScenePhase)
/// Дії викликані подіями життєвого циклу додатку (з ScenePhase)
public enum ApplicationLifecycleActions {
    
    /// App became active (foreground and ready)
    /// Додаток став активним (на передньому плані і готовий)
    public struct DidBecomeActive: Action {}
    
    /// App will resign active (before background/inactive)
    /// Додаток втратить активність (перед фоном/неактивністю)
    public struct WillResignActive: Action {}
    
    /// App entered background
    /// Додаток перейшов у фоновий режим
    public struct DidEnterBackground: Action {}
    
    /// App will enter foreground
    /// Додаток переходить на передній план
    public struct WillEnterForeground: Action {}
}

public enum ApplicationState: Equatable {
    case active
    case inactive
    case background
    
    public static let initial = ApplicationState.active
}

public func reduce(_ state: ApplicationState, with action: Action) -> ApplicationState {
    switch action {
    case is ApplicationLifecycleActions.DidEnterBackground:
        return .background
    case is ApplicationLifecycleActions.DidBecomeActive:
        return .active
    case is ApplicationLifecycleActions.WillResignActive:
        return .inactive
    default:
        return state
    }
}
