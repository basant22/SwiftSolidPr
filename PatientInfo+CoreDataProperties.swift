//
//  PatientInfo+CoreDataProperties.swift
//  SwiftSolidPr
//
//  Created by apple on 12/05/26.
//
//

import Foundation
import CoreData


extension PatientInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientInfo> {
        return NSFetchRequest<PatientInfo>(entityName: "PatientInfo")
    }

    @NSManaged public var patientId: Int16
    @NSManaged public var file: Data
    func convertToPatient()->PatientData{
        PatientData(patientId: Int(patientId), file: file)
    }
}

extension PatientInfo : Identifiable {

}

struct PatientData:Identifiable{
    var id = UUID()
    
var patientId: Int
    var file: Data
}
