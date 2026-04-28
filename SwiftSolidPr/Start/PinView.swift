//
//  PinView.swift
//  Volttic
//
//  Created by ShwetJ on 15/12/22.
//

import SwiftUI
import Combine
struct MyTextField: UIViewRepresentable {
    @Binding var text: String
   // var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        return UITextField()
    }
    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: [
//            NSAttributedString.Key.kern: 0.3
//        ])
        uiView.attributedText = NSAttributedString(string: self.text, attributes: [
            NSAttributedString.Key.kern: 1.3
        ])
    }
}
struct PinViewLink: View {
    @State private var showMenu = false
    var body: some View{
        GeometryReader{ view in
            PinView(showMenu: $showMenu)
                .navigationBarBackButtonHidden(true)
                .frame(width: view.size.width,height: view.size.height)
                .offset(x:showMenu ? view.size.width/2:0)
            if showMenu{
                SideMenu(showMenu: $showMenu)
                    .frame(width: view.size.width/2)
                    .transition(.move(edge: .leading))
            }
        }
    }
}
struct PinView: View {
    @Binding  var showMenu:Bool
    @State private var txtPin = ""
    @State private var showPin = false
    @State private var emptyOtp = false
    @State private var invalidOtp = false
    @State private var navigateToForgetPin = false
    @State private var navigateToNext = false
    @FocusState private var isFocused : Bool
    @State private var errorMessage:String = ""
    @State private var showAlert:Bool = false
    @State private var isInternet:Bool = false
    @State private var showLoader:Bool = false
   // @StateObject private var userProfile:Profile = Profile(result: ResultProfile())
    @State private var userProfile:ResultProfile = ResultProfile()
    @State  var connect:ConnectorDetail = ConnectorDetail()
    @EnvironmentObject private var language: MyLanguage
    @EnvironmentObject private var router: Router
    var body: some View {
        NavigationStack(path: $router.path){
           // NavigationView{
            ZStack{
                Theme.AppBG
                VStack{
                    
                    VStack{
                        Image(ImageType.VoltticImg)
                            .resizable()
                            .scaledToFit()
                            .frame(width: Theme.width - 80,height: 60)
                    }
                    .padding(.top,60)
                    Text(Theme.punchLine.localizableString(language: language.selectedLanguage))
                        .foregroundColor(Theme.textGray)
                        .font(Font.custom("Poppins-SemiBold", size: 18.0))
                        .frame(width: Theme.width - 20,height: 40)
                    VStack{
                        Image("car_station")
                            .resizable()
                            .scaledToFit()
                            .frame(height: Theme.height/3)
                    }
                    .padding(.top,4)
                    .frame(width: Theme.width - 10,height: Theme.height/3)
                   // Spacer()
                    HStack{
                        Text("Enter_your_pin".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18.0)
                           // .foregroundColor(Theme.textGray)
                            .padding(.leading,45)
                           // .font(Font.custom("Poppins-Light", size: 18.0))
                        Spacer()
                    }
                    VStack{
                            if showPin{
                                    TextField("", text: $txtPin)
                                    .kerning((
                                        Theme.width - 150
                                    )/4 )
                                    .font(.system(size: 16.0,weight: .regular))
                                    .keyboardType(.numberPad)
                                    .focused($isFocused)
                                   // .foregroundColor
                                    .frame(maxWidth: .infinity,maxHeight: 50)
                                    .padding(.horizontal,30)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done".localizableString(language: language.selectedLanguage)) {
                                                isFocused = false
                                            }
                                        }
                                    }
                                    .onReceive(Just(txtPin)) { _ in
                                        txtPin = String(txtPin.prefix(4))
                                    }
                            }else{
                                SecureField("", text: $txtPin)
                                    .font(.system(size: 16.0,weight: .regular))
                                    .kerning((
                                        Theme.width - 150
                                    )/4 )
                                    .keyboardType(.numberPad)
                                    .focused($isFocused)
                                    .frame(maxWidth: .infinity,maxHeight: 50)
                                    .padding(.horizontal,30)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done".localizableString(language: language.selectedLanguage)) {
                                                isFocused = false
                                            }
                                        }
                                    }
                                    .onReceive(Just(txtPin)) { _ in
                                        txtPin = String(txtPin.prefix(4))
                                    }
                            }
                        }
                    .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.VoltticColor.opacity(0.45)))
                    .overlay(RoundedRectangle(cornerRadius: 18.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
                    .frame(width:Theme.width - 80,height: 50)
                    //.padding(.top,2)
                    
                    HStack{
                        Image(systemName: showPin ? "checkmark.square" : "square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23,height: 23)
                            .padding(.leading,5)
                            //.foregroundColor(Theme.textGray)
                        Text("Show_Pin".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18.0)
                            .padding(.leading,5)
                           // .foregroundColor(Theme.textGray)
                            //.font(Font.custom("Poppins-Light", size: 16.0))
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation {
                            showPin.toggle()
                        }
                    }
                    .padding(.top,4)
                    .padding(.leading,45)
                    HStack{
                        Text("Forgot pin?".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18)
                            .foregroundColor(Theme.Primary)
                            .onTapGesture {
                                Task{
                                    do{
                                        try await forgotPin()
                                    }catch{
                                        
                                    }
                                }
                            }
                        Spacer()
                    }
                    .padding(.top,20)
                    .padding(.leading,45)
                    Spacer()
                    VStack{
                        Button {
                            if !txtPin.isEmpty {
                                Task{
                                    try? await verifyOtp()
                                 }
                            }else{
                                emptyOtp = true
                            }
                        } label: {
                            Text("Login".localizableString(language: language.selectedLanguage))
                                .kerning(2.0)
                                .semiBold(size: 19.0)
                                .foregroundColor(.white)
                                //.padding(.bottom,30)
                                .frame(width:Theme.width - 60,height: 50)
                                .font(Font.custom("Poppins-Medium", size: 18.0))
                        }
                    }
                    .frame(width:Theme.width - 60,height: 44)
                    .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.Primary))
                    .padding(.bottom,40)
                }
                if showLoader{
                    MyLoader(isInternet: $isInternet)
                        .onTapGesture {
                            showLoader = false
                        }
                }
                
            }.onAppear{
                txtPin = ""
                showLoader = false
            }
            
            .navigationDestination(for: ResultProfile.self, destination: { value in
                HomeLink(user: value)
            })
            .navigationDestination(for: ConnectorDetail.self, destination: { value in
               // connect = value
                SelectQuantityView(connector: value,isAddVehicle:false)
            })
            .navigationDestination(for: NavigateToOtp.self, destination: { value in
                OtpView(mobileNumber: myData.sahred.mobileNumber,connector:value.connect,comingFrom: value.from,claculateCharging:value.calculatedCharging, selectedAmount: myData.sahred.amountToCharge)
            })
            .navigationDestination(for: NavigateToProceedDriver.self, destination: { value in
                ProceedToChargeView(connector: value.connect,isAddVehicle: true, isDriver: true,ruppeToPay: myData.sahred.amountToCharge)
            })
            .navigationDestination(for: NavigateToProceedCustomer.self, destination: { value in
                ProceedController(connector: value.connect, isDriver: true,selectedAmount:value.selectedAmount,calculatedCharging:value.claculatedCharging)
                            .navigationBarBackButtonHidden(true)
            })
            .navigationDestination(for: NavigateToProcessedAmount.self, destination: { value in
                ProcessedAmountView(connector: value.connect, driverVehicle: value.vehicle,processedAmount: value.rupeeToPay)
            })
            .navigationDestination(for: NavigateToStopCharging.self, destination: { value in
                //StopChargingView(time: value.time, usedFrom: value.from)
                ChargingViewBel(time: value.time, usedFrom: value.from,orderId:Int(value.orderId) ?? 0,amountToPay:Int(value.amountToPay))
            })
            .navigationDestination(for: NavigateToMap.self, destination: { value in
                MapView(station:value.results,allStation:value.results)
            })
            .navigationDestination(for: VoltticStations.self, destination: { value in
                StationDetail(station: value)
            })
            .navigationDestination(for: NavigateToMyVehicle.self, destination: { value in
                MyVehicles()
            })
            .navigationDestination(for: NavigateToLeadger.self, destination: { value in
                LedgerList()
            })
            .navigationDestination(for: NavigateToHistory.self, destination: { value in
                ChargingHistoryList()
            })
            .navigationDestination(for: NavigateToPayment.self, destination: { value in
               // PaymentView()
                PaymentController()
                    .navigationBarBackButtonHidden(true)
            })
            .navigationDestination(for: NavigateToMyBookings.self, destination: { value in
                MyBookings()
                   
            })
            .navigationDestination(for: NavigationToContactWeb.self, destination: { value in
                openWeb(url: value.url)
            })
            .navigationDestination(for: NavigateToCostomerProcessed.self, destination: { value in
               // CustomerProcessedAmountView(transactionAmount:Int(self.amountToCharge),orderId:orderid,vehicleReg:(self.selectedVehicle.registrationNumber) ,from: "Qr",walletBalance:(self.connector.walletBalance)))
                CustomerProcessedAmountView(transactionAmount:Int(value.amount),orderId:value.orderId,vehicleReg:value.vehicleReg,from: "Qr")
            })
            //
            .navigationDestination(for: NavigateToSlot.self, destination: { value in
                SlotView(slotsdata:value.slots!,rateKWh:value.rateOfKWh, connCode:value.connectorCode,connName:value.connectorName)
                })
            .navigationDestination(for: NavigateToCpo.self, destination: { value in
                CpoRegister(fName: value.fName, lName: value.lName, eMail: value.email, contactNum: value.contact, enrollmentNum: "")
                })
            .navigationDestination(for: NavigateToCpoStatus.self, destination: { value in
                CpoStatusView()
                })
            .navigationDestination(for: NavigateViewLiveMoniterStart.self, destination: { value in
                StartLiveMoniter(companyCode: value.companyCode)
                })
            .navigationDestination(for: NavigateToLiveStatus.self, destination: { value in
                LiveMoniteringView(companyCode: value.companyCode)
                })
            .navigationDestination(for: NavigateToTransaction.self, destination: { value in
                TransactionReports(companyCode: value.companyCode)
                })
            .navigationDestination(for: NavigateToOperation.self, destination: { value in
                CpoOperations(companyCode: value.companyCode)
                })
            
            .navigationDestination(for: String.self, destination: { value in
                 if value == "OtpView"{
                     OtpView(mobileNumber: myData.sahred.mobileNumber,connector:nil,comingFrom: "ForgotPin", claculateCharging: "")
                }
                else if value == "SetPin"{
                    SetPin(fName:myData.sahred.profile.firstName,lName:myData.sahred.profile.lastName,email: myData.sahred.profile.emailID,changePin: .constant(true))
                }
                else if value == "ProfileLinkView"{
                    ProfileLinkView(user: myData.sahred.profile)
                }
                else if value == "AboutUsView"{
                    AboutUsView()
                }
                else if value == "ContactUsLink"{
                    ContactUsLink()
                }
                else if value == "ReportIssueLink"{
                    ReportIssueLink()
                }
                else if value == "PrivacyPolicyView"{
                    PrivacyPolicyView()
                }
                else if value == "SettingViewLink"{
                    SettingViewLink()
                }
                else if value == "FaqViewLink"{
                    FaqViewLink()
                }
                else if value == "LiveChargingViewLink"{
                    LiveChargingViewLink(from:"Sidemenu")
                }else if value == "LiveChargingViewLinkHome"{
                    LiveChargingViewLink(from:"Home")
                }
                
               
            })
//            .navigationDestination(isPresented: $navigateToNext) {
//                HomeLink(user: userProfile)
//                //StopChargingView()
//            }
//            .navigationDestination(isPresented: $navigateToForgetPin) {
//                OtpView(mobileNumber: myData.sahred.mobileNumber,comingFrom: "ForgotPin")
//                //StopChargingView()
//            }
            .alert("Internet connection is not available".localizableString(language: language.selectedLanguage), isPresented: $isInternet) {
                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
            }
            .alert("Enter_your_pin_msg".localizableString(language: language.selectedLanguage), isPresented: $emptyOtp) {
                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
            }
            .alert(errorMessage, isPresented: $showAlert) {
                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
            }
            .ignoresSafeArea()
        }
    }
    
    func forgotPin() async throws{
        print("mobileNumber = \(myData.sahred.mobileNumber)")
        showLoader = true
        let req = VerifyMobile(argument1: ArgumentMobile(mobileNumber: myData.sahred.mobileNumber, applicationId: myData.sahred.appId))
        let urlReq = Network.myRequest(connector: Connector.VerifyMobileNumber, request: req, type: .post)
        if let data = await VerifyMobileNumber().getVrifyResponse(req: urlReq){
            showLoader = false
            if data.success == true{
               navigateToForgetPin = true
                router.path.append("OtpView")
            }else{
                router.path.append(userProfile)
               // navigateToForgetPin = false
            }
        }
    }
    fileprivate func verifyOtp() async throws {
          showLoader = true
        let req = AuthenticateUser(argument1: AuthenticateInfo(mobileNumber: myData.sahred.mobileNumber, applicationId: myData.sahred.appId, pin: txtPin))
        let status = await HandelOtpVrification.authenticate(req: req)
         
         if status.1 == false{
             showLoader = false
             errorMessage = status.0.message
             showAlert = true
         }else{
             try? await requestForGettingProfile()
         }
     }
    fileprivate func requestForGettingProfile() async throws {
        if let data = ToUserDefaults.fetchUserProfile(){
            let arg = ArgumentUserRegistration(applicationID: myData.sahred.appId, deviceName: Theme.DeviceType, firstName: data.firstName, lastName: data.lastName, mobileNumber: myData.sahred.mobileNumber, pin: txtPin, emailID: data.emailID, ev: "")
            let req = RegisterNew(argument1:arg)
            let handelReq = HandelRegisterRequest()
           let myProfile = await handelReq.getUserProfile(req: req)
            showLoader = false
            if myProfile.1 {
                userProfile = myProfile.2!.result
                myData.sahred.profile = myProfile.2!.result
                if ToUserDefaults.removeUserProfileClass() == false{
                    ToUserDefaults.saveUserProfileClass(object: userProfile)
                }
               // self.navigateToNext = true
                try? await fetchUserVehicle()
                router.path.append(userProfile)
            }else{
                errorMessage = myProfile.0.message
                showAlert = true
            }
        }
        
        
    }
    func fetchUserVehicle() async throws{
        //let pin = ToUserDefaults.fetchPIN()
        let userDetail = NewUserDetail(mobileNumber: myData.sahred.profile.mobileNumber, applicationId: myData.sahred.profile.applicationID ?? "0", deviceName: "IOS", firstName: myData.sahred.profile.firstName, lastName: myData.sahred.profile.lastName, pin: txtPin, emailId: myData.sahred.profile.emailID, ev: "", appVersionCode: String(myData.sahred.profile.appVersionCode ?? 0))
       // let userDetail = UserDetail(mobileNumber: myData.sahred.mobileNumber, applicationId:  myData.sahred.appId)
        let getVehReq = GetUserVehicle(argument1: userDetail)
        let handelReq = HandelVehicleRequest()
        let userVehList = await handelReq.getVehicleList(request:getVehReq)
        if userVehList.vList.count > 0  {
            myData.sahred.isVehicleAdded = true
           // myVehicleList.vList = userVehList.vList
           // try? await Task.sleep(nanoseconds: 1_000_000_000)
        }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
//        PinView(showMenu: .constant(false))
//            .environmentObject(MyLanguage())
//            .environment(\.colorScheme,.dark)
        PinView(showMenu: .constant(false))
            .environmentObject(MyLanguage())
            .environmentObject(Router())
            .environment(\.colorScheme,.light)
    }
}
