//
//  TabView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import SwiftUI
import ReduxCore

struct TabView: View {
    
    @Environment(\.appRouterStateStore) private var store: ObservableStore<AppRouterState>?
    
    var body: some View {
        if let store = store {
            SwiftUI.TabView(selection: Binding(
                get: { store.state.tabbarState.selectedTab },
                set: { newTab in
                    store.dispatch(action: TabActions.SelectedTab(tab: newTab))
                })) {
                    CounterView()
                        .environment(\.appRouterStateStore, store)
                        .tabItem {
                            Image(systemName: "number.circle")
                            Text("Counter")
                        }
                        .tag(Tab.counter)
                    
                    ImageView()
                        .environment(\.appRouterStateStore, store)
                        .tabItem {
                            Image(systemName: "photo")
                            Text("Image")
                        }
                        .tag(Tab.image)
                }
        } 
    }
}
