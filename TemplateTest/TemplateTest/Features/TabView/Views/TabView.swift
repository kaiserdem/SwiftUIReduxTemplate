//
//  TabView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import SwiftUI
import ReduxCore


struct TabView: View {
    
    @Environment(\.tabStateStore) private var store: ObservableStore<TabState>?
    
    var body: some View {
        if let store = store {
            SwiftUI.TabView(selection: Binding(
                get: { store.state.selectedTab },
                set: { newTab in
                    store.dispatch(action: TabActions.SelectedTab(tab: newTab))
                })) {
                    CounterView()
                        .tabItem {
                            Image(systemName: "number.circle")
                            Text("Counter")
                        }
                        .tag(Tab.counter)
                    
                    ImageView()
                        .tabItem {
                            Image(systemName: "photo")

                            Text("Image")
                        }
                        .tag(Tab.image)
                }
            
        }
        
    }
}
