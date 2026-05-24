//
//  PatientDb.swift
//  SwiftSolidPr
//
//  Created by apple on 12/05/26.
//

import Foundation
import CoreData
protocol DBProtocol{
    func saveRecord(patientId: Int,file:Data)async throws
    func fetchRecord(patientId:Int)async throws ->[PatientData]
}

class PatientDbInfo:DBProtocol{
    func saveRecord(patientId: Int,file:Data)async throws {
       try await DBHandler.shared.context.perform{
           let bcgContext = DBHandler.shared.context
           let patientInfo = PatientInfo(context: bcgContext)
           patientInfo.patientId = Int16(patientId)
           patientInfo.file = file
               try bcgContext.save()
        }
//        DBHandler.shared.performBackgroundTask { backgroundContext in
//            let patientInfo = PatientInfo(context: backgroundContext)
//            patientInfo.patientId = String(patientId) + type
//            patientInfo.fileName = fileName
//
//                try? backgroundContext.save()
//
//
//        }
    }
    
    func fetchRecord(patientId: Int)async throws ->[PatientData]{
        let context = DBHandler.shared.context
        var pData = [PatientData]()
        do{
           
        // 1. Create a fetch request to find the specific employee
        let fetchRequest =  PatientInfo.fetchRequest()
            //NSFetchRequest<PatientInfo>(entityName: "PatientInfo")
        
        // 2. Filter by ID
        fetchRequest.predicate = NSPredicate(format: "patientId == %d", patientId)
        
        // 3. Performance optimization: we only need one object
        
        try await context.perform {
            let results = try context.fetch(fetchRequest)
            for result in results {
                pData.append(result.convertToPatient())
            }
        }
        }catch{
            throw error
        }
        return pData
    }
}
