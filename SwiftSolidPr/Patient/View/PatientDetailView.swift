//
//  PatientDetail.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import SwiftUI

struct PatientDetailView: View {
    @Environment(\.dismiss) var dismiss
    let patientId:Int
    @ObservedObject var viewModal:PatientViewModal
    @State private var isNavigating = false
    @EnvironmentObject var loginVM:LoginViewModel
    var body: some View {
        VStack{
            if viewModal.isLoading{
                SpinnerView()
            }else if viewModal.patientDetail == nil{
                VStack{
                    Text("Failed to load patient details. Please try again.")
                        .font(.headline)
                    Image(systemName:"exclamationmark.square.fill")
                        .foregroundColor(.blue)
                }
            }else if let patient = viewModal.patientDetail{
                List{
                   
                    Section(header: Text("Patient name --> \(loginVM.name)")){
                            
                            PatientName(patientDetail: patient)
                            
                        }
                        Section(header: Text("Location")) {
                            Text("Ward: \(patient.ward.name) · \(patient.ward.number) · \(patient.ward.bed)")
                                .font(.body)
                        }
                        
                        Section(header: Text("Care Team")) {
                            Text("Treating Doctor: \(patient.treatingDoctor.name) (\(patient.treatingDoctor.specialty))")
                                .font(.body)
                        }
                        Section(header:Text("Clinical")){
                            VStack(alignment: .leading, spacing: 4){
                                if !patient.conditions.isEmpty{
                                    Text("Conditions:\(patient.conditions.joined(separator: ","))")
                                        .font(.caption)
                                }
                                if !patient.symptoms.isEmpty{
                                    Text("Symptoms:\(patient.symptoms.joined(separator: ","))")
                                        .font(.caption)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        if !patient.medications.isEmpty {
                            Section(header:Text("Clinical")){
                                ForEach(patient.medications){ medication in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(medication.name)
                                            .font(.body)
                                        Text("\(medication.dose) · \(medication.frequency)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        Section(header: Text("Updated At")) {
                            Text("Last updated: \(formatDate(patient.lastUpdatedUTC))")
                                .font(.caption)
                        }
                        
                    
                }
            }
            if viewModal.patientPdfData.count > 0{
                NavigationLink(destination:
                                ViewPdfReport(pData:viewModal.patientPdfData),
                               isActive:$isNavigating) {
                    EmptyView()
                }
            }
            if(viewModal.isLoading == false && viewModal.patientDetail != nil){
                VStack{
                    Button(action: {
                        Task{
                            if viewModal.isView{
                                 await viewReport()
                            }else{
                                await downloadReport()
                            }
                            
                        }
                    }){
                        Text( viewModal.isView ? "View Report":viewModal.isDownloading ? "":"Download Report")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .overlay {
                                if viewModal.isDownloading {
                                    ProgressView()
                                        .tint(.white) // Use tint for iOS 15+ to change color
                                }
                            }
                        // .animation(.easeInOut(duration: 0.3), value: viewModal.isView)
                        
                        
                    }
                }
                .padding()
                
                
            }
        }
        //._navigationDestination(item: <#T##SwiftUI.Binding<Item>?#>, storyboardName: <#T##String#>)
        .listStyle(.insetGrouped)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement:.principal){
                Text("Patient Detail")
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action:{
                    Task {
                        try await viewModal.getPatientDetail(patientId: patientId)
                    }
                }){
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.blue)
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    Task {
                        dismiss()
                    }
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blue)
                }
            }
        }
        .task {
            do{
                try await viewModal.getPatientDetail(patientId: patientId)
               // let pId = String(patientId) + viewModal.patientDetail
                try await viewModal.CheckForPreDownload(patientId: patientId)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    private func formatDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .short
           return formatter.string(from: date)
       }
    private func downloadReport() async {
        do{
            try await viewModal.downloadReports(for: patientId)
            try await viewModal.CheckForPreDownload(patientId: patientId)
        }catch{
            print( "download error=\(error.localizedDescription)")
        }
    }
    private func viewReport() async {
        do{
            try await viewModal.fetchReportFor(patientId: patientId)
            self.isNavigating = true
        }catch{
            print( "download error=\(error.localizedDescription)")
        }
    }
}
//struct PatientDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientDetailView(patientId: 0, viewModal: PatientViewModal(repo: PatientRepo.defaultRepo))
//    }
//}
