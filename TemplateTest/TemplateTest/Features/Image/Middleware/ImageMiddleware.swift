//
//  ImageMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore
import Dependencies

struct ImageMiddleware {
    @Dependency(\.imageManager) var imageManager
    
    func middleware() -> Middleware<TabState> {
        { dispatch, action, oldValue, newValue in
            switch action {
            case  is ImageActions.DownloadImage:
                Task {
                    do {
                        let urlString = "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg"
                        let image = try await imageManager.downloadImage(urlString)
                        
                        await MainActor.run {
                            dispatch(ImageActions.CompletionImage(image: image))
                        }
                    } catch {
                        await MainActor.run {
                            dispatch(ImageActions.ErrorDownloadImage(error: error))
                        }
                    }
                }
            default:
                break
            }
        }
    }
}
