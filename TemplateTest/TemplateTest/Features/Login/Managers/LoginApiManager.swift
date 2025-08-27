//
//  LoginApiManager.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 26/08/2025.
//

import Foundation
import Dependencies

protocol LoginApi {
    func login(_ email: String) async throws -> String
}

struct LoginApiManager: LoginApi {
    
    let errorProbability: Double = 0.25
    
    func login(_ email: String) async throws -> String {
        
        // https request simulation
        try await Task.sleep(for: .seconds(2))
        
        if Double.random(in: 0...1) < errorProbability {
            throw NSError(domain: "LoginError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid email address"])
        }
        
        return "Some token 1234567890"
    }
}

enum LoginApiKey: DependencyKey {
    static let liveValue: LoginApi = LoginApiManager()
}

extension DependencyValues {
    var loginApiManager: LoginApi {
        get { self[LoginApiKey.self] }
        set { self[LoginApiKey.self] = newValue }
    }
}
