//
//  TokenHandler.swift
//  SwiftSolidPr
//
//  Created by apple on 07/05/26.
//

import Foundation

actor TokenStore {
    private var accessToken: String?
    private var refreshToken: String?
    private var refreshTask: Task<String, Error>?   // key: only ONE refresh at a time

    func validToken() async throws -> String? {
        if let token = accessToken {
            return token
        }
        return nil
//        return try await refreshAccessToken()
    }

    private func refreshAccessToken() async throws -> String {
        // If a refresh is already in flight, await ITS result — don't start another
        if let existing = refreshTask {
            return try await existing.value
        }

        let task = Task<String, Error> {
            defer { refreshTask = nil }
            let newToken = ""
            //try await AuthAPI.refresh(refreshToken!)
            self.accessToken = newToken
            return newToken
        }

        refreshTask = task
        return try await task.value
    }
}
