//
//  UserDetail.swift
//  TestProj
//
//  Created by Kumar Basant on 07/12/22.
//

import SwiftUI

struct UserInfo: View {
    @Binding var info:String
    
    var heading:String
    var placeHolder:String
    var body: some View {
        VStack(alignment: .leading){
            Text(heading)
                .semiBold(size: 19.0)
                //.font(.system(size: 17.0,weight: .medium))
                .padding(.leading,2)
                .padding(.bottom,4)
                .foregroundColor(Theme.textGray)
            VStack(alignment:.center){
                TextField(placeHolder, text: $info)
                    .medium(size: 17.0)
                    //.font(.system(size: 17.0,weight: .medium))
                    .padding()
                    .autocorrectionDisabled(true)
            }
            .frame(width: Theme.width - 55,height: 44.0)
            .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.grayColor))
           // .overlay(RoundedRectangle(cornerRadius: 12.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
        }
    }
}
//struct UserInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInfo(info: .constant(""), heading: "", placeHolder: "")
//    }
//}

struct UserInfoes: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "chevron.left") // set image here
                    .aspectRatio(contentMode: .fit)
                     Text("Go back")
                }
                .foregroundColor(.black)
            }
        }
//    @State private var fName = "Kumar"
//    @State private var lName = "Basant"
//    @State private var email = //"basant.kumar22@gmail.com.com"
    @State  var fName = ""
    @State  var lName = ""
    @State  var email = ""
    @State private var isTermsSelected = false
    @State private var navigateToNext = false
    @State private var unableToPerform = false
    @State private var invalidDevice = false
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var showTC = false
    @EnvironmentObject private var language: MyLanguage
    @EnvironmentObject private var router: Router
    var body: some View {
        //  NavigationStack{
       
        ZStack{
            Theme.AppBG
            ScrollView(showsIndicators: false){
            VStack{
                VStack{
                    Image("logo_volttic_dashboard")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                }
                .frame(width: Theme.width - 120,height: 60)
                .padding(.top,UIDevice().hasNotch ?  50 : 20)
                Spacer()
                HStack{
                    Text("Personal Information")
                        .bold(size: 25)
                        .padding(.bottom,30)
                    Spacer()
                }
                .padding(.top,20)
                .frame(width:Theme.width - 55)
                
                UserInfo(info: $fName, heading: "First_Name".localizableString(language: language.selectedLanguage), placeHolder: "Enter_Your_First_Name".localizableString(language: language.selectedLanguage))
                UserInfo(info: $lName, heading: "Last_Name".localizableString(language: language.selectedLanguage), placeHolder: "Enter_Your_Last_Name".localizableString(language: language.selectedLanguage))
                UserInfo(info: $email, heading: "Email".localizableString(language: language.selectedLanguage), placeHolder: "Enter_Your_Email_Id".localizableString(language: language.selectedLanguage))
                Terms(isSelected: $isTermsSelected) {
                    showTC = true
                }
                Spacer()
                Button {
                    Task{
                        let status =  await registerUser()
                        if status.1 == false{
                            errorMessage = status.0.message
                            showAlert = status.0.error!
                        }
                    }
                    
                } label: {
                    Text("NEXT".localizableString(language: language.selectedLanguage))
                        .kerning(2.0)
                        .medium(size: 17.0)
                        .foregroundColor(.black)
                        .frame(width: Theme.width - 50,height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.VoltticColor))
                }
                .padding(.bottom,20)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("BACK".localizableString(language: language.selectedLanguage))
                        .kerning(2.0)
                        .medium(size: 17.0)
                        .foregroundColor(.black)
                        .frame(width: Theme.width - 50,height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.Primary))
                }
                .padding(.bottom,20)
            }
            
            
        }
    }
            .alert(errorMessage.localizableString(language: language.selectedLanguage), isPresented: $showAlert) {
                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
            }
            .sheet(isPresented: $showTC, content: {
                MyPrivacyWeb()
            })
//            .navigationDestination(isPresented: $navigateToNext) {
//                SetPin(fName:fName,lName: lName,email: email,changePin: .constant(false))
//            }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        
    }
    func registerUser() async -> (Success,Bool){
        let validate = UserBasicInfos.validateInfo(fName: fName, lName: lName, email: email, isConditionAccepted: isTermsSelected)
        if validate.error == false{
         // navigateToNext = true
            router.path.append(NavigateToSetPin(id: 1, fName: fName, lName: lName, email: email))
            //router.path.append("SetPin")
        }else{
            return (validate,false)
        }
        return (validate,false)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoes()
            .environmentObject(MyLanguage())
            .environmentObject(Router())
    }
}

struct NavigateToSetPin:Codable,Hashable{
    let id:Int?
    let fName:String
    let lName:String
    let email:String
    init(id: Int?, fName: String, lName: String,email:String) {
        self.id = id
        self.fName = fName
        self.lName = lName
        self.email = email
    }
}
