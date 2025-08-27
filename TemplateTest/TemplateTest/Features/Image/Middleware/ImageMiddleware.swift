//
//  ImageMiddleware.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore
import UIKit

struct ImageMiddleware {
    
    func middleware() -> Middleware<AppRouterState> {
        { dispatch, action, oldState, newState in
            switch action {
            case is ImageActions.DownloadImage:
                Task {
                    try await Task.sleep(for: .seconds(1))
                    
                    let size = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                    UIColor.blue.setFill()
                    UIRectFill(CGRect(origin: .zero, size: size))
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    if let image = image {
                        await MainActor.run {
                            dispatch(ImageActions.CompletionImage(image: image))
                        }
                    } else {
                        await MainActor.run {
                            dispatch(ImageActions.ErrorDownloadImage(error: NSError(domain: "ImageError", code: 1, userInfo: nil)))
                        }
                    }
                }
            default:
                break
            }
        }
    }
}
