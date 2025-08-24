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
    
    private let store = ObservableStore<TabState>(
        store: Store<TabState>(
            state: TabState.inital,
            reducer: TabState.reduce,
            middlewares: [
                DebugLogMiddleware<TabState>().middleware(),
                APICounterMiddleware().middleware(),
                ImageMiddleware().middleware()
            ]
        )
    )
    var body: some Scene {
        WindowGroup {
            TabView()
                .environment(\.tabStateStore, store)
        }
    
    
//    private let store = ObservableStore<ImageState>(
//        store: Store<ImageState>(
//            state: ImageState.inital,
//            reducer: ImageState.reduce,
//            middlewares: [
//                DebugLogMiddleware<ImageState>().middleware(),
//                ImageMiddleware().middleware()
//            ]
//        )
//    )
//    var body: some Scene {
//        WindowGroup {
//            ImageView()
//                .environment(\.imageStateStore, store)
//        }
    
    
    
    
    
//    private let store = ObservableStore<CounterState>(
//        store: Store<CounterState>(
//            state: CounterState.initial,
//            reducer: CounterState.reduce,
//            middlewares: [
//                DebugLogMiddleware<CounterState>().middleware(),
//                               APICounterMiddleware().middleware()
//            ]
//        )
//    )
//    
//    var body: some Scene {
//        WindowGroup {
//            CounterView()
//            .environment(\.counterStateStore, store)
//        }
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
