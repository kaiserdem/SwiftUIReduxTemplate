//
//  TemplateTestApp.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import SwiftUI
import ReduxCore

@main
struct TemplateTestApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    private let store = ObservableStore<AppRouterState>(
        store: Store<AppRouterState>(
            state: AppRouterState.initial,
            reducer: AppRouterState.reduce,
            middlewares: [
                DebugLogMiddleware<AppRouterState>().middleware(),
                LoginMiddleware().middleware(),
                APICounterMiddleware().middleware(),
                ImageMiddleware().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            AppRouterView()
                .environment(\.appRouterStateStore, store)
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                store.dispatch(action: ApplicationLifecycleActions.DidBecomeActive())
            case .inactive:
                store.dispatch(action: ApplicationLifecycleActions.WillResignActive())
            case .background:
                store.dispatch(action: ApplicationLifecycleActions.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
}
