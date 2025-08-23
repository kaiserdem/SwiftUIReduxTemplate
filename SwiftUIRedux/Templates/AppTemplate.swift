//
//  App.swift
//  YourProjectName
//
//  Created by You on Date.
//

import SwiftUI
import ReduxCore

/// Main SwiftUI App with Redux architecture
/// Використовує нову архітектуру з протоколом StateReducer
/// Головний SwiftUI App з Redux архітектурою
/// Використовує нову архітектуру з протоколом StateReducer
@main
struct YourApp: App {
    
    // Global store instance
    // Глобальний екземпляр store
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: AppState.reduce, // ✅ Використовуємо нову архітектуру
            middlewares: [
                // Core middlewares (always include these)
                // Основні middleware (завжди включайте ці)
                DebugLogMiddleware<AppState>().middleware(),
                
                // TODO: Add your custom middlewares here
                // TODO: Додайте ваші кастомні middleware тут
                // APIMiddleware().middleware(),
                // UserActionMiddleware().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Inject store into Environment
                // Інжектуємо store в Environment
                .environment(\.appStore, store)
        }
        // SwiftUI native lifecycle handling
        // Нативне керування lifecycle в SwiftUI
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                store.dispatch(action: Actions.AppLifecycle.DidBecomeActive())
            case .inactive:
                store.dispatch(action: Actions.AppLifecycle.WillResignActive())
            case .background:
                store.dispatch(action: Actions.AppLifecycle.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
    
    // SwiftUI scene phase monitoring
    // Моніторинг фази сцени SwiftUI
    @Environment(\.scenePhase) private var scenePhase
}

/// Example main view
/// Приклад головного view
struct ContentView: View {
    // Get store from Environment
    // Отримуємо store з Environment
    @Environment(\.appStore) private var store: ObservableStore<AppState>?
    
    var body: some View {
        VStack(spacing: 20) {
            if let store = store {
                // Display current state
                // Відображаємо поточний стан
                Text("App State: \(store.state.application == .active ? "Active" : "Inactive")")
                
                if store.state.isLoading {
                    ProgressView("Loading...")
                } else {
                    VStack {
                        Text("Items count: \(store.state.items.count)")
                        
                        ForEach(store.state.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                
                if let error = store.state.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
                
                // Example buttons using new Actions
                // Приклад кнопок використовуючи нові Actions
                Button("Start Loading") {
                    store.dispatch(action: Actions.StartLoading())
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Add Item") {
                    store.dispatch(action: Actions.AddSingleItem(item: "New Item"))
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Clear Items") {
                    store.dispatch(action: Actions.ClearItems())
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                
            } else {
                Text("Store not available")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
