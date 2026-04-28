//
//  PatientRepo.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation
protocol PatientRepoProtocol{
    func getPatientsRecord(request:PatientReq) async throws->PagedPatientsResponse
    func searchPatient(name:String) async throws->[PatientRecord]
}

class PatientRepo:PatientRepoProtocol{
    private let http:ApiDispatcher
    private let reqBuilder:PatientURLRequestBuilder
    init(http:ApiDispatcher,reqBuilder:PatientURLRequestBuilder){
        self.http = http
        self.reqBuilder = reqBuilder
    }
    static var defaultRepo : PatientRepoProtocol{
        let http:ApiDispatcher = NetworkCall()
        let reqBuilder:PatientURLRequestBuilder = PatientURLRequest()
        return PatientRepo(http: http, reqBuilder: reqBuilder)
    }
    func getPatientsRecord(request:PatientReq) async throws->PagedPatientsResponse{
        guard let requset = self.reqBuilder.makeGetPatientRequest(take: request.take, skip: request.skip) else{
            throw NetworkError.invalidRequest
        }
        do{
            let data:PagedPatientsResponse = try await http.networkCall(requset)
            return data
        }catch{
            throw error
        }
    }
    func searchPatient(name:String) async throws->[PatientRecord]{
        guard let requset = self.reqBuilder.makeGetPatientSearchRequest(patintName: name) else{
            throw NetworkError.invalidRequest
        }
        do{
            let data:[PatientRecord] = try await http.networkCall(requset)
            return data
        }catch{
            throw error
        }
    }
}
