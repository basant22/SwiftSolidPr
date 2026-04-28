//
//  PatientList.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import SwiftUI

struct PatientList: View {
    @StateObject private var viewModel:PatientViewModal = PatientViewModal(repo: PatientRepo.defaultRepo)
    
    func loadPatints(_ patient:PatientRecord)-> some View{
        NavigationLink(destination:Text("Hello")){
            VStack(alignment:.leading){
                Text(patient.fullName)
                    .fontWeight(.medium)
                Text("\(patient.wardNumber) \(patient.bed)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(patient.doctorName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth:.infinity)
            .padding(.vertical,15)
            .background(RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                            .fill(Color.cyan)
                            
            )
        }
        .buttonStyle(.plain) // Remove the default blue text color/opacity
        .padding(.horizontal)
    }
    var filterPatient:[PatientRecord]{
        if viewModel.searchText.isEmpty{
            return viewModel.patients
        }else if viewModel.searchedPatients.isEmpty{
            return viewModel.patients.filter({$0.fullName.lowercased().contains(viewModel.searchText.lowercased())})
        }else{
            return viewModel.searchedPatients
        }
    }
    var loadingView:some View{
        VStack(){
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading Patient Text..")
                .foregroundColor(.gray)
                .padding(.top,10)
        }
        
        .frame(maxWidth:.infinity)
        .padding(.vertical,40)
        
        
    }
    var body: some View {
        VStack{
        if viewModel.isLoading{
            self.loadingView
            
        }else{
          
                ScrollView(showsIndicators: false){
                    LazyVStack(spacing: 16){
                        ForEach(filterPatient){ patient in
                           PatientRowView(patient: patient)
                        }
                    }
                }
                
                
                //                List(filterPatient){ patient in
                //                    self.loadPatints(patient)
                //                }
                //                .listStyle(.insetGrouped)
                //                .navigationBarTitleDisplayMode(.large)
            
            .searchable(text: $viewModel.searchText,placement:.navigationBarDrawer(displayMode: .always))
           
        }
        }
        .task {
            if(viewModel.patients.isEmpty){
                await loadPatients()
            }
        }
    }
    func loadPatients()async{
        await viewModel.getPatient(request: PatientReq(take: 10, skip: 0))
    }
}

struct PatientList_Previews: PreviewProvider {
    static var previews: some View {
        PatientList()
    }
}
