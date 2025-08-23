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
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: AppState.reduce,
            middlewares: [
                DebugLogMiddleware<AppState>().middleware(),
                               APIMiddleware().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            CounterView()
            .environment(\.appStateStore, store)
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
    
    @Environment(\.scenePhase) private var scenePhase
}
