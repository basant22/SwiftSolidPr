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
}

class PatientViewModal:ObservableObject,PatientViewModalProtocol{
    @Published var patients:[PatientRecord] = []
    @Published var searchedPatients:[PatientRecord] = []
    @Published var isLoading:Bool = false
    @Published var searchError:String = ""
    @Published var searchText:String = ""{
        didSet{
           initiateSearch()
        }
    }
    
   // private let debounc:Debouncing
    private var repo:PatientRepoProtocol
    // Keep a reference to the pending search task
        private var searchTask: Task<Void, Never>?
    init(repo:PatientRepoProtocol,debounc:Debouncing = Debouncing(interval: 1.5, que: .global())){
       // self.debounc = debounc
        self.repo = repo
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
                        self.searchError = error.localizedDescription
                    }
                }
            }
        }
    func getPatient(request:PatientReq) async {
        do{
            let patRees:PagedPatientsResponse? = try await self.repo.getPatientsRecord(request: request)
            DispatchQueue.main.async {
                self.patients = patRees?.records ?? []
            }
           
        }catch{
            DispatchQueue.main.async {
                self.searchError = error.localizedDescription
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
                self.searchError = error.localizedDescription
            }
        }
        
    }
}
