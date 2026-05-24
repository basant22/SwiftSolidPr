//
//  Interceptor.swift
//  SwiftSolidPr
//
//  Created by apple on 07/05/26.
//

import Foundation
protocol RequestInterceptor {
    func intercept(_ request: URLRequest) async throws -> URLRequest
}

// Auth token injection
final class AuthInterceptor: RequestInterceptor {
    private let tokenStore: TokenStore

    init(tokenStore: TokenStore) { self.tokenStore = tokenStore }

    func intercept(_ request: URLRequest) async throws -> URLRequest {
        var r = request
         let token = try await tokenStore.validToken()
        r.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return r
    }
}
// Logging interceptor
final class LoggingInterceptor: RequestInterceptor {
    func intercept(_ request: URLRequest) async throws -> URLRequest {
        let method = request.httpMethod ?? "?"
        let url = request.url?.absoluteString ?? "?"
        print("→ \(method) \(url)")
        return request
    }
}
