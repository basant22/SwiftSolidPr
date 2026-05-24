//
//  PatientViewModal.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation

protocol PatientViewModalProtocol{
    func getPatient(request:PatientReq) async
    func searchPatient(name:String) async
    func getPatientDetail(patientId:Int) async throws
   // func getPatientReport(patientId:Int) async throws
    func downloadReports(for patientId: Int) async throws
    func CheckForPreDownload(patientId:Int) async throws
    func fetchReportFor(patientId:Int) async throws
}

class PatientViewModal:ObservableObject,PatientViewModalProtocol{
    @Published var patients:[PatientRecord] = []
    @Published var searchedPatients:[PatientRecord] = []
    @Published var patientDetail:PatientDetail?
    @Published var patientReport:[Report] = []
    @Published var patientPdfData:[PatientData] = []
    @Published var isDownloading:Bool = false
    @Published var isView:Bool = false
    var onObserveLoading:(Bool)->Void = {_ in}
    @Published var isLoading:Bool = false{
        didSet{
            onObserveLoading(isLoading)
        }
    }
    @Published var errorMessage:String = ""
    @Published var searchText:String = ""{
        didSet{
           initiateSearch()
        }
    }
    
   // private let debounc:Debouncing
    private var repo:PatientRepoProtocol
    private var dbInfo:DBProtocol
    // Keep a reference to the pending search task
        private var searchTask: Task<Void, Never>?
    init(repo:PatientRepoProtocol,debounc:Debouncing = Debouncing(interval: 1.5, que: .global()),dbInfo:DBProtocol = PatientDbInfo()){
       // self.debounc = debounc
        self.repo = repo
        self.dbInfo = dbInfo
    }
    private func initiateSearch()  {
            // 1. Cancel the previous search immediately
            searchTask?.cancel()
            
            // 2. Start a new task
            searchTask = Task {
                do {
                    // 3. Debounce: Wait for 1s
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    
                    // 4. Check if we were cancelled during the sleep
                    try Task.checkCancellation()
                    
                    guard !searchText.isEmpty else {
                        DispatchQueue.main.async {
                        self.searchedPatients = []
                        }
                        return
                    }
                    
                     await searchPatient(name: searchText)
                    
                } catch is CancellationError {
                    // Do nothing, this is expected when user is still typing
                } catch {
                    // 5. Handle errors by updating the UI, not throwing
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    func getPatient(request:PatientReq) async {
        do{
            DispatchQueue.main.async {
            self.isLoading = true
            }
            let patRees:PagedPatientsResponse? = try await self.repo.getPatientsRecord(request: request)
            DispatchQueue.main.async {
                self.isLoading = false
                self.patients = patRees?.records ?? []
                self.searchedPatients = patRees?.records ?? []
            }
           
        }catch{
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    func searchPatient(name:String) async  {
        guard name.isEmpty == false else { return}
        do{
            let record:[PatientRecord]? = try await self.repo.searchPatient(name: name)
            DispatchQueue.main.async {
                self.searchedPatients = record ?? []
            }
        }catch{
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
    func getPatientDetail(patientId:Int) async throws{
        guard  patientId != 0  else { return}
        do{
            DispatchQueue.main.async {
            self.isLoading = true
            }
            let pDetail:PatientDetail = try await self.repo.getPatientDetail(patientId: patientId)
            DispatchQueue.main.async {
                self.isLoading = false
                self.patientDetail = pDetail
            }
        }catch{
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
    }
    func downloadReports(for patientId:Int) async throws{
        guard  patientId != 0  else { return}
        do{
            DispatchQueue.main.async {
            self.isDownloading = true
            }
            let report:[Report] = try await self.repo.getPatientReports(for: patientId)
            try await self.repo.savePatientReportsToDocumentDirectory(reports: report, patientId: patientId)
            DispatchQueue.main.async {
                self.isDownloading = false
               // self.patientReport = report
            }
        }catch{
            DispatchQueue.main.async {
                self.isDownloading = false
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
    }
    func CheckForPreDownload(patientId:Int)async throws   {
        let result = try await self.dbInfo.fetchRecord(patientId: patientId)
        DispatchQueue.main.async {
            if result.count > 0{
                self.isView = true
            }else{
                self.isView = false
            }
        }
    }
    func fetchReportFor(patientId:Int) async throws {
        let result = try await self.dbInfo.fetchRecord(patientId: patientId)
        DispatchQueue.main.async {
            self.patientPdfData = result
        }
    }
}
