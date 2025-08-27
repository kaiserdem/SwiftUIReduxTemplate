//
//  ImageManager.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import SwiftUI
import Dependencies

protocol ImageApi {
    func downloadImage(_ urlString: String) async throws -> UIImage
}

struct ImageManager: ImageApi {
    func downloadImage(_ urlString: String) async throws -> UIImage {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Failed image data"])
        }
        return image
        
    }
    
}

enum ImageApiKey: DependencyKey {
    static let liveValue: ImageApi = ImageManager()
}

extension DependencyValues {
    var imageManager: ImageApi {
        get { self[ImageApiKey.self] }
        set { self[ImageApiKey.self] = newValue }
    }
}
