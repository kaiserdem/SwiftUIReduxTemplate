//
//  ImageView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import SwiftUI
import ReduxCore

struct ImageView: View {
    
    @Environment(\.tabStateStore) private var store: ObservableStore<TabState>?

    var body: some View {
        if let store = store {
            VStack {
                ScrollView {
                    ForEach(store.state.imageState.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .onAppear {
                store.dispatch(action: ImageActions.DownloadImage())
            }
        }
    }
}
