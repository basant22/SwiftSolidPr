//
//  PatientReport.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation
struct PatientReport: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let reports: [Report]
}

// MARK: - Report
struct Report: Decodable {
    let reportId, type: String
    let dateUtc: Date
    let url: String
}
