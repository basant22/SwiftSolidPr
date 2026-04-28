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
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView{
            ZStack{
                LinearGradient(colors: [.green,.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                    VStack{
                        TextField("UserId", text: $userId)
                           // .blackBorder()
                            .textIcon(systemImage: "person.fill", isVisible: .constant(false))
//                            .padding()
//                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black,lineWidth: 1.0))
//                            .frame(width: geometry.size.width*0.90, height: 54, alignment: .center)
                        
                        Group{
                            if isVisible{
                                SecureField("Password", text: $password)
                            }else{
                                TextField("Password", text: $password)
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
                                isLoggedIn = true
                            }
                            .frame(width: geometry.size.width*0.70, height: 50, alignment: .center)
                            .background(.blue)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        }
                    }
                    .padding()
                    Spacer()
                }
                .frame(width: geometry.size.width,alignment: .center)
            }
            .ignoresSafeArea()
           
            }
           
           // .toolbar(.hidden, for: .navigationBar)
        }
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
