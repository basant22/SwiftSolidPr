//
//  PatientDetail.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation

struct PatientDetail: Codable {
    let id: Int
    let mrn, fullName: String
    let age: Int
    let sex: String
    let ward: Ward
    let treatingDoctor: TreatingDoctor
    let conditions, symptoms: [String]
    let medications: [Medication]
    let lastUpdatedUTC: Date

    enum CodingKeys: String, CodingKey {
        case id, mrn, fullName, age, sex, ward, treatingDoctor, conditions, symptoms, medications
        case lastUpdatedUTC = "lastUpdatedUtc"
    }
}

// MARK: - Medication
struct Medication: Codable,Identifiable {
    let name, dose, frequency: String
    var id :String{
        return("\(name)-\(dose)-\(frequency)")
    }
}

// MARK: - TreatingDoctor
struct TreatingDoctor: Codable {
    let name, specialty: String
}

// MARK: - Ward
struct Ward: Codable {
    let name, number, bed: String
}
