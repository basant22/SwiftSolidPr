//
//  LoginView.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import SwiftUI

struct LoginView: View {
    @State private var userId:String = ""
    @State private var password:String = ""
    @State private var isLoggedIn = false
    @State private var isVisible = false
    @State private var isShowing = false
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var isRunView = false
    @StateObject private var loginVM = LoginViewModel()
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView{
            ZStack{
                LinearGradient(colors: [.green,.white], startPoint: .topLeading, endPoint: .bottomTrailing)
               
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                    VStack{
                        TextField("UserId", text: $loginVM.name)
                           // .blackBorder()
                            .textIcon(systemImage: "person.fill", isVisible: .constant(false))
//                            .padding()
//                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black,lineWidth: 1.0))
//                            .frame(width: geometry.size.width*0.90, height: 54, alignment: .center)
                        
                        Group{
                            if isVisible{
                                TextField("Password", text: $password)
                            }else{
                                SecureField("Password", text: $password)
                                
                            }
                        }
                       // SecureField("Password", text: $password)
                          //  .blackBorder()
                            .textIcon(systemImage: "lock.fill",isSecure:true, isVisible: $isVisible)
//                            .padding()
//                            .frame(width: geometry.size.width*0.90, height: 54, alignment: .center)
//                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black,lineWidth: 1))
//                            .padding()
                        
                       
                        NavigationLink(
                            destination: PatientList(),
                            isActive: $isLoggedIn
                        ) {
                            Button("LogIn"){
                               // isLoggedIn = true
                                isShowing = true
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:48)
                            .padding(.horizontal)
                           
                           // .frame(width: geometry.size.width*0.70, height: 50, alignment: .center)
                            .background(.blue)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        }
                        .padding(.top,40)
                        NavigationLink(
                            destination: PhotoGridView(),
                            isActive: $isRunView
                        ) {
                            Button("RunLoop View"){
                               // isLoggedIn = true
                                isRunView = true
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:48)
                            .padding(.horizontal)
                           
                           // .frame(width: geometry.size.width*0.70, height: 50, alignment: .center)
                            .background(.blue)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        }
                        .padding(.top,40)
                        Button("Show Alert"){
                           // showAlert = true
                            showSheet = true
                        }
                        .padding(.top,40)
                    }
                    .padding()
                    Spacer()
                }
                .frame(width: geometry.size.width,alignment: .center)
                .monitorNetwork()
                if isShowing {
                    // Dimmed Background
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { isShowing = false }
                    
                    // The Popup Card
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                        Text("Delivery Successful")
                            .fontWeight(.bold)
                        Button("Dismiss") {
                            isShowing = false
                            isLoggedIn = true
                        }
                    }
                    .zIndex(1)
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity)) // The "Pop" effect
                }
                
//                .sheet(isPresented: $showSheet) {
//                            VStack {
//                                Text("Patient: John Doe")
//                                    .font(.headline)
//                                // You can put any View here, like your SpinnerView!
//                                Button("Close") { showSheet = false }
//                            }
//                            .presentationDetents([.medium, .large]) // iOS 16+: allows half-height
//                        }
            }
            .alert("Submit Shipment?", isPresented: $showAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Confirm") { /* Logic here */ }
                    } message: {
                        Text("Once confirmed, the patient delivery cannot be reversed.")
                    }
                    .sheet(isPresented: $showSheet, content: {
                        VStack {
                            Text("Patient: John Doe")
                                .font(.headline)
                            // You can put any View here, like your SpinnerView!
                            Button("Close") { showSheet = false }
                        }
                    
                    })
            .ignoresSafeArea()
           
            }
            
           
           // .toolbar(.hidden, for: .navigationBar)
        }
        .navigationBarHidden(true)
        .environmentObject(loginVM)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

class LoginViewModel:ObservableObject{
    @Published var name:String = ""
    
}
