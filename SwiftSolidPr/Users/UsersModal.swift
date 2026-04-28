//
//  UsersModal.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation
// 1. Lowest level of the hierarchy
struct Geo: Codable {
    let lat: String
    let lng: String
}

// 2. Intermediate level
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// 3. Root level (Renamed to User for clarity)
struct UserInterfaceData: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address?
    let phone: String
}

