//
//  UserNumber.swift
//  TestProj
//
//  Created by Kumar Basant on 06/12/22.
//

import SwiftUI
import Combine
struct VerifyNumber: View {
   // @State private var mobileNumber = "7503103938"
    @State private var mobileNumber = ""
    @State private var userInfos = false
    @State private var emptyMobileNumber = false
    @State private var showLoader = false
    @State private var networkError = false
    @State private var authFail = false
    @State private var isInternet = false
    @State private var countMobileNumber = ""
    @FocusState private var isFocused : Bool
    @State private var offsetY = CGSize(width: Theme.width, height: 150)
    @EnvironmentObject private var language: MyLanguage
    @EnvironmentObject private var router:Router
    var body: some View {
       // NavigationStack{
            ZStack{
                Theme.AppBG
                VStack(alignment: .center){
                    VStack{
                        Image("logo_volttic_dashboard")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                    }
                    .frame(width: Theme.width - 120,height: 60)
                    .padding(.top,60)
                  //  .overlay(RoundedRectangle(cornerRadius: 12.0,style: .continuous).stroke(Theme.Primary,lineWidth: 1.0))
                    .padding(.top,20)
                    VStack(alignment: .leading){
                        Text("Your_Phone!".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 23.0)
                            .padding(.leading,2)
                            .padding(.top,5)
                            .foregroundColor(Theme.textGray)
                        Text("Enter_Mobile_Number".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18.0)
                            .padding(.leading,2)
                            .padding(.top,10)
                            .foregroundColor(Theme.textGray)
                        // VStack(alignment: .leading){
                        
                        
                        VStack(alignment: .center){
                            HStack(alignment: .center){
                                Text("+91")
                                    .kerning(2.0)
                               // Image("India")
                                  //  .resizable()
                                 //   .scaledToFit()
                                    //.frame(width: 20,height: 20)
                               // "Mobile_Number".localizableString(language: language.selectedLanguage),
                                    .padding(.leading,10)
                                TextField("",text: $mobileNumber)
                                    .light(size: 17.0)
                                    .keyboardType(.numberPad)
                                    .kerning(3.0)
                                    .padding(.leading,5)
                                    .focused($isFocused)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done".localizableString(language: language.selectedLanguage)) {
                                                isFocused = false
                                            }
                                            .medium(size: 17.0)
                                            .foregroundColor(.teal)
                                         }
                                    }
                                    .onReceive(Just(mobileNumber)) { _ in
                                        mobileNumber = String(mobileNumber.prefix(10))
                                        countMobileNumber = String(mobileNumber.count)
                                    }
                                Spacer()
                                Text(countMobileNumber)
                                    .light(size: 14.0)
                                    .padding(.trailing,10)
                                    .foregroundColor(.red)
                            }
                            .padding(.bottom,15)
                            .alert("Please_enter_mobile_number".localizableString(language: language.selectedLanguage), isPresented: $emptyMobileNumber) {
                                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
                            }
                        }
                        .padding(.top,20)
                        .frame(height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.grayColor))
                        .overlay(RoundedRectangle(cornerRadius: 12.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
                        Text("4_digit_OTP".localizableString(language: language.selectedLanguage))
                            .light(size: 16.0)
                            .font(.footnote)
                            .padding(.top,10)
                            .padding(.horizontal,6)
                            .foregroundColor(Theme.OffGray)
                        Spacer()
                        Button {
                            
//                            Task{
//                              try?  await fetchStationNearMyLocation()
//                            }
                            
                            if ValidateMobileNumber.isEmpty(mobileNumber:mobileNumber).error == false{
                                    Task{
                                        userInfos = await verifyMobileNumber()
                                        if userInfos{
                                            router.path.append("OtpView")
                                        }
                                    }
                                }else{
                                    emptyMobileNumber = true
                                }
                             
                        } label: {
                            Text("NEXT".localizableString(language: language.selectedLanguage))
                                .kerning(2.0)
                                .medium(size: 18.0)
                                .foregroundColor(.black)
                                .frame(height: 44.0)
                                .frame(maxWidth: .infinity)
                                
                        }
                        .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.VoltticColor))
                        .padding(.bottom,30)
                        //.padding(.horizontal,10)
                        .alert("Some network error".localizableString(language: language.selectedLanguage), isPresented: $networkError) {
                            Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
                        }
                    }
                   // .overlay(RoundedRectangle(cornerRadius: 12.0,style: .continuous).stroke(Theme.Primary,lineWidth: 1.0))
                    .padding(.top,30)
                    .padding(.horizontal,20)
                }
                
                .alert(Theme.noInternet.localizableString(language: language.selectedLanguage), isPresented:  $isInternet){
                                            Button("Ok".localizableString(language: language.selectedLanguage), role: .cancel, action: {})
                                        }
                .alert("Authentication_failed".localizableString(language: language.selectedLanguage), isPresented: $authFail) {
                    Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
                }
                if showLoader{
                    MyLoader(isInternet: $isInternet)
                        .onTapGesture {
                            showLoader = false
                        }
                   // SpinnerView(hideLoader: $showLoader)
                        .offset(y:0)
                }
            }
            .ignoresSafeArea()
           // .navigationBarBackButtonHidden(true)
//            .navigationDestination(isPresented: $userInfos) {
//                //SetPin(fName:"",lName: "",email: "",changePin: .constant(false))
//                OtpView(mobileNumber: mobileNumber,connector:nil,comingFrom: "")
//             }
       // }
        
    }
    
//    func fetchStationNearMyLocation() async throws{
//      //  showLoader = true
//        let data = await HandelMapRequest().fetchStations()
//       // showLoader = false
//        guard let result = data else {return}
//          // stationLocation = result
//        print("result=\(result)")
//    }
    func verifyMobileNumber() async -> Bool{
        print("appId=\(myData.sahred.appId)")
            showLoader = true
            myData.sahred.mobileNumber = mobileNumber
        let req = VerifyMobile(argument1: ArgumentMobile(mobileNumber: mobileNumber, applicationId: myData.sahred.appId))
       let urlReq = Network.myRequest(connector: Connector.VerifyMobileNumber, request: req, type: .post)
        if let data = await VerifyMobileNumber().getVrifyResponse(req: urlReq){
            showLoader = false
            if data.success == true{
                return true
            }else{
                authFail = true
                return false
            }
        }else{
            networkError = true
            showLoader = false
            return false
        }
//        let data = await ApiPostRequest.kindOf(Connector.VerifyMobileNumber, request: req, response: VerifyMobileResponse.self)
//            if data != nil && data?.success == true{
//                showLoader = false
//                return true
//            }
//            return false
    }
}

struct UserNumber_Previews: PreviewProvider {
    static var previews: some View {
        VerifyNumber()
            .environmentObject(MyLanguage())
            .environmentObject(Router())
    }
}
