//
//  PatientModal.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation
struct PatientRecord: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let wardNumber: String
    let bed: String
    let doctorName: String
    // 1. Add the property (var so it can be toggled)
    var isFavorite: Bool = false
    
    // 2. Map the JSON keys (standard practice)
    enum CodingKeys: String, CodingKey {
        case id, fullName, wardNumber, bed, doctorName
    }
    // 3. Custom Init for Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.wardNumber = try container.decode(String.self, forKey: .wardNumber)
        self.bed = try container.decode(String.self, forKey: .bed)
        self.doctorName = try container.decode(String.self, forKey: .doctorName)
        
        // isFavorite is NOT decoded, so it defaults to false
        self.isFavorite = false
    }
}

// MARK: - Top-level response

struct PagedPatientsResponse: Decodable {
    let pagination: Pagination
    let records: [PatientRecord]
}

// MARK: - Pagination

struct Pagination: Decodable {
    let pageNumber: Int
    let pageSize: Int
    let totalCount: Int
}
