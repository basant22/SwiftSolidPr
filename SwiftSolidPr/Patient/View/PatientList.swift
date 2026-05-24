//
//  PatientList.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import SwiftUI

struct PatientList: View {
    @StateObject private var viewModel:PatientViewModal = PatientViewModal(repo: PatientRepo.defaultRepo)
    @State private var isFavorite:Bool = false
   
    var filterPatient:[PatientRecord]{
        if viewModel.searchText.isEmpty{
            return viewModel.patients
        }else if viewModel.searchedPatients.isEmpty{
            return viewModel.patients.filter({$0.fullName.lowercased().contains(viewModel.searchText.lowercased())})
        }else{
            return viewModel.searchedPatients
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
            if viewModel.isLoading{
                SpinnerView()
            }else if viewModel.patients.count == 0{
                VStack{
                    Button {
                        Task{
                            if(viewModel.patients.isEmpty){
                                await loadPatients()
                            }
                        }
                    } label: {
                        VStack{
                            Text("Failed to load patient list. Please try again.")
                                .font(.headline)
                            Image(systemName:"exclamationmark.square.fill")
                                .font(.system(size: 50))
                            //                            .foregroundColor(.green)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    
                }
            }else if viewModel.searchedPatients.count > 0 {
                ScrollView(showsIndicators: false){
                    LazyVStack(spacing: 16){
                        ForEach($viewModel.searchedPatients){ $patient in
                            PatientRowView(patient: $patient, viewModal: self.viewModel)
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement:.principal){
                    Text("Patient List")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        Task {
                            await loadPatients()
                        }
                    }){
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                    }
                }
                
            }
            .task {
                if(viewModel.patients.isEmpty){
                    await loadPatients()
                }
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

struct PDetail:UIViewControllerRepresentable{
    typealias UIViewControllerType = UIViewController
    let viewModal:PatientViewModal
    let patientId:Int
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = PatientDetailVC(viewModal: viewModal,patientId: patientId)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}
