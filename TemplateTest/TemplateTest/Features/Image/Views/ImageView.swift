//
//  ImageView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import SwiftUI
import ReduxCore

struct ImageView: View {
    
    @Environment(\.appRouterStateStore) private var store: ObservableStore<AppRouterState>?

    var body: some View {
        if let store = store {
            VStack {
                if store.state.tabbarState.imageState.isLoading {
                    ProgressView()
                        .padding()
                }
                
                ScrollView {
                    ForEach(store.state.tabbarState.imageState.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                
                Button("Download New Image") {
                    store.dispatch(action: ImageActions.DownloadImage())
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .onAppear {
                store.dispatch(action: ImageActions.DownloadImage())
            }
        }
    }
}

