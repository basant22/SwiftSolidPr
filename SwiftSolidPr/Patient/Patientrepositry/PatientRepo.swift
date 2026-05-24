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
    func getPatientDetail(patientId:Int) async throws->PatientDetail
    
    func getPatientReports(for patientId: Int) async throws -> [Report]
    func savePatientReportsToDocumentDirectory(reports:[Report], patientId: Int) async throws
}

class PatientRepo:PatientRepoProtocol{
    private let http:ApiDispatcher
    private let reqBuilder:PatientURLRequestBuilder
    private let interceptor:RequestInterceptor
    init(http:ApiDispatcher,reqBuilder:PatientURLRequestBuilder,interceptor:RequestInterceptor){
        self.http = http
        self.reqBuilder = reqBuilder
        self.interceptor = interceptor
    }
    static var defaultRepo : PatientRepoProtocol{
        let http:ApiDispatcher = NetworkCall()
        let reqBuilder:PatientURLRequestBuilder = PatientURLRequest()
        let token = TokenStore()
        let interceptor:RequestInterceptor = AuthInterceptor(tokenStore: token)
        return PatientRepo(http: http, reqBuilder: reqBuilder,interceptor:interceptor)
    }
    func getPatientsRecord(request:PatientReq) async throws->PagedPatientsResponse{
        guard let requset = self.reqBuilder.makeGetPatientRequest(take: request.take, skip: request.skip) else{
            throw NetworkError.invalidRequest
        }
        do{
            let req = try await interceptor.intercept(requset)
            let data:PagedPatientsResponse = try await http.networkCall(req)
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
    func getPatientDetail(patientId:Int) async throws->PatientDetail{
        guard let requset = self.reqBuilder.makeGetPatientDetailRequest(patintId: patientId) else{
            throw NetworkError.invalidRequest
        }
        do{
            let pDetail : PatientDetail = try await http.networkCall(requset)
            return pDetail
        }catch{
            throw error
        }
    }
    func getPatientReports(for patientId: Int) async throws -> [Report] {
        guard let request = self.reqBuilder.makeGetPatientReportRequest(patintId: patientId) else{
            throw NetworkError.invalidRequest
        }
        do{
            let patientReport:[PatientReport]? = try await self.http.networkCall(request)
            guard let  pReport = patientReport , let report = pReport.first?.reports else{
                return []
            }
            return report
        }catch{
            throw error
        }
    }
    func savePatientReportsToDocumentDirectory(reports: [Report], patientId: Int) async throws {
        
        let store = FileStore()
        let dbStore = PatientDbInfo()
       try await withThrowingTaskGroup(of:Result<(Data,Report),Error>.self){ group in
            
           /*for report in reports{
               guard let url = URL(string: report.url), let request = self.reqBuilder.downloadReport(url: url) else { continue
               }
               do{
                   let fileUrl:URL = try await self.http.fileDownloadAsync(request:request)
                   _ = try store.saveFile(tempURL: fileUrl,
                                          rootDir: "\(patientId)",
                                          path:report.type ,
                                          fileName: report.reportId)
                   
               }catch{
                   throw error
               }
           }*/
           
           
            for report in reports{
                guard let url = URL(string: report.url), let request = self.reqBuilder.downloadReport(url: url) else { continue
                }
                group.addTask{
                    do{
                        let file:Data = try await self.http.networkCallForFile(url)
                        return .success((file,report))
                    }catch{
                        return .failure(error)
                    }
                }
            }
            
           for try await result in group{
                
                switch result{
                    
                case .success(let (file,report)):
                  //  let pid = "\(patientId)" + report.type
                   
//                    let fileUri = try store.saveFile(tempURL: fileUrl,
//                                           rootDir: "\(patientId)",
//                                           path:report.type ,
//                                           fileName: report.reportId)
                   // let fixedURL = fileUri.deletingLastPathComponent()
                    try await dbStore.saveRecord(patientId: patientId, file: file)
                case .failure(let error):throw error
                }
            }
        }
       
    }
}
