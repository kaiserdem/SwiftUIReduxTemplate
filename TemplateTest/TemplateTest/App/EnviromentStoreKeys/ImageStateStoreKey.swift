//
//  ImageStateStoreKey.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore
import SwiftUI

struct ImageStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<ImageState>? = nil
}

extension EnvironmentValues {
    var imageStateStore: ObservableStore<ImageState>? {
        get { self[ImageStateStoreKey.self] }
        set { self[ImageStateStoreKey.self] = newValue }
    }
}
