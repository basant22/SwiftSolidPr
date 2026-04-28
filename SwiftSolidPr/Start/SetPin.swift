//
//  SetPin.swift
//  TestProj
//
//  Created by Kumar Basant on 07/12/22.
//

import SwiftUI
import Combine
struct SetPin: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var btnBack : some View {
//        Button(
//            action: {
//            self.presentationMode.wrappedValue.dismiss()
//            }) {
//                HStack {
//                Image(systemName: "chevron.left") // set image here
//                    .aspectRatio(contentMode: .fit)
//                     Text("Go back")
//                }
//                .foregroundColor(.black)
//            }
//        }
    @State private var txt1 = ""
    @State private var txt2 = ""
    @State private var txt3 = ""
    @State private var txt4 = ""
    
    @State private var txt5 = ""
    @State private var txt6 = ""
    @State private var txt7 = ""
    @State private var txt8 = ""
    
    @State private var navigateToNext = false
    @State private var errorMsg:String = ""
    @State private var showMessage:Bool = false
    @State private var pin1 = ""
    @State private var pin2 = ""
    @State private var miMatchedPin = false
    @State private var pinOne = false
    @State private var pinTwo = false
    @State private var olderPin = false
   // @State private var endEditing = false
  //  @FocusState var focusedField:Fields?
   // @FocusState var focusedFieldN:FieldsN?
    @State private var showLoader = false
    @State private var isInternet = false
    @State var userProfile:ResultProfile = ResultProfile()
   // @StateObject var userProfile:Profile = Profile(result: ResultProfile())
    @EnvironmentObject private var language: MyLanguage
    @EnvironmentObject private var router:Router
    @EnvironmentObject private var stateManager : LaunchScreenStateManager
    //= Profile(result: ResultProfile())
    @FocusState private var isFocused : Bool
    @State private var oldPin = ""
    var fName = ""
    var lName = ""
    var email = ""
    @Binding var changePin :Bool
    var body: some View {
        // NavigationStack{
        ZStack{
            Theme.AppBG
            VStack{
                VStack{
                    Image("logo_volttic_dashboard")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                }
                .frame(width: Theme.width - 120,height: 60)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .padding(.top,60)
                HStack{
                    Text("Nearly finished!".localizableString(language: language.selectedLanguage))
                        .bold(size:30)
                        .padding(.leading,45)
                    Spacer()
                }
                .padding(.top,25)
                .padding(.bottom,15)
                VStack(alignment: .center) {
                    if changePin{
                        HStack{
                            Text("Enter_current_PIN".localizableString(language: language.selectedLanguage))
                                .semiBold(size: 18.0)
                                .padding(.leading,45)
                            Spacer()
                        }
                        VStack{
                       // SecureField("", text: $oldPin)
                            TextField("", text: $oldPin,onEditingChanged: { active in
                                if active{
                                    olderPin = true
                                    pinOne = false
                                    pinTwo = false
                                }
                            })
                            .kerning((
                                Theme.width - 150
                            )/4 )
                            
                            .font(.system(size: 16.0,weight: .regular))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .frame(maxWidth: .infinity,maxHeight: 50)
                            .padding(.horizontal,30)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button(olderPin ? "Done".localizableString(language: language.selectedLanguage):"") {
                                        isFocused = false
                                    }
                                }
                            }
                    }
                .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.VoltticColor.opacity(0.45)))
                .overlay(RoundedRectangle(cornerRadius: 18.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
                .frame(width:Theme.width - 80,height: 50)
                    }
                    HStack{
                        Text(changePin ? "Enter new PIN".localizableString(language: language.selectedLanguage) : "Set Your Login PIN".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18)
                            .padding(.top,15)
                            .padding(.bottom,1)
                            .padding(.leading,45)
                            .foregroundColor(Theme.textGray)
                        Spacer()
                    }
//                EquatableView(content: OtpFrame(txt1: $txt1, txt2: $txt2, txt3: $txt3, txt4: $txt4,endEditing: {
//                    UIApplication.shared.endEditing()
//                }))
                      //  .padding(.bottom,30)
                    VStack{
                        TextField("", text: $pin1,onEditingChanged: { active in
                            if active{
                                pinOne = true
                                pinTwo = false
                                olderPin = false
                            }
                        })
                            .kerning((
                                Theme.width - 150
                            )/4 )
                            .font(.system(size: 16.0,weight: .regular))
                            .keyboardType(.numberPad)
                             
                           // .focused($isFocused)
                            .frame(height: 50)
                            .padding(.horizontal,30)
                            .onReceive(Just(pin1)) { _ in
                                pin1 = String(pin1.prefix(4))
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button(pinOne ? "Done".localizableString(language: language.selectedLanguage):"") {
                                        //isFocused = false
                                        UIApplication.shared.endEditing()
                                    }
                                }
                            }
                        
                    }
                    .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.VoltticColor.opacity(0.45)))
                        .overlay(RoundedRectangle(cornerRadius: 18.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
                        .frame(width:Theme.width - 80,height: 50)
                    HStack{
                        Text(changePin ? "Re enter new PIN".localizableString(language: language.selectedLanguage) :"Re enter your pin".localizableString(language: language.selectedLanguage))
                            .semiBold(size: 18)
                            .padding(.bottom,1)
                            .padding(.top,20)
                            .padding(.leading,45)
                            .foregroundColor(Theme.textGray)
                        Spacer()
                    }
//                    ConfirmOtpFrame(txt5: $txt5, txt6: $txt6, txt7: $txt7, txt8: $txt8,endEditing: {
//                        UIApplication.shared.endEditing()
//                    })
                    VStack{
                        TextField("", text: $pin2,onEditingChanged: { active in
                            if active{
                                pinOne = false
                                pinTwo = true
                                olderPin = false
                            }
                        })
                            .kerning((
                                Theme.width - 150
                            )/4 )
                            .font(.system(size: 16.0,weight: .regular))
                            .keyboardType(.numberPad)
                          //  .focused($isFocused)
                            .frame(maxWidth: .infinity,maxHeight: 50)
                            .padding(.horizontal,30)
                            .onReceive(Just(pin2)) { _ in
                                pin2 = String(pin2.prefix(4))
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button(pinTwo ? "Done".localizableString(language: language.selectedLanguage):"") {
                                       // isFocused = false
                                        UIApplication.shared.endEditing()
                                    }
                                }
                            }
                    }
                    .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.VoltticColor.opacity(0.45)))
                    //.overlay(RoundedRectangle(cornerRadius: 18.0,style: .continuous).stroke(Theme.VoltticColor,lineWidth: 1.0))
                        .frame(width:Theme.width - 80,height: 50)
                    Spacer()
                    //if !txt1.isEmpty && !txt2.isEmpty && !txt3.isEmpty && !txt4.isEmpty && !txt5.isEmpty && !txt6.isEmpty && !txt7.isEmpty && !txt8.isEmpty{
                    if !pin1.isEmpty && !pin2.isEmpty {
                        VStack(alignment:.center){
                            Button {
                              //  pin1 = txt1+txt2+txt3+txt4
                              //  pin2 = txt5+txt6+txt7+txt8
                             //   navigateToNext = true
                                Task{
                                    if changePin {
                                        let statusPin =  await checkPin(oldPin:oldPin,pin1: pin1, pin2: pin2)
                                        if statusPin.1{
                                            var _ =  await registerUser()
                                        }else{
                                            errorMsg = statusPin.0.message
                                            showMessage = statusPin.0.error!
                                        }
                                    }else{
                                        let statusPin =  await checkPin(pin1: pin1, pin2: pin2)
                                        if statusPin.1{
                                            var _ =  await registerUser()
                                        }else{
                                            errorMsg = statusPin.0.message
                                            showMessage = statusPin.0.error!
                                        }
                                    }
                                   
                                }
                            } label: {
                                Text("NEXT".localizableString(language: language.selectedLanguage))
                                    .medium(size: 18.0)
                                    .kerning(2.0)
                                    .foregroundColor(.black)
                                    .frame(width: Theme.width - 50,height: 44.0)
                                    .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.Primary))
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                        .padding(.bottom,30)
                    }
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("BACK".localizableString(language: language.selectedLanguage))
                            .medium(size: 18.0)
                            .kerning(2.0)
                            .foregroundColor(.black)
                            .frame(width: Theme.width - 50,height: 44.0)
                            .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.Primary))
                    }
                    .padding(.bottom,30)
                }
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .padding(.top,10)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .alert(errorMsg.localizableString(language: language.selectedLanguage), isPresented: $showMessage) {
                Button("OK".localizableString(language: language.selectedLanguage), role: .cancel){}
            }
            .alert(Theme.noInternet.localizableString(language: language.selectedLanguage), isPresented:  $isInternet){
                                        Button("Ok".localizableString(language: language.selectedLanguage), role: .cancel, action: {})
                                    }
            if showLoader{
                MyLoader(isInternet: $isInternet)
                    .onTapGesture {
                        showLoader = false
                    }
              //  SpinnerView(hideLoader: $showLoader)
                    .offset(y:0)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
//        .navigationDestination(isPresented: $navigateToNext) {
//           HomeLink(user: userProfile)
//        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    fileprivate func checkPin(oldPin:String,pin1:String,pin2:String) async->(Success , Bool){
        let olderPin = ToUserDefaults.fetchPIN()
        if oldPin == olderPin{
            let validate = UserPin.validatePin(pin1: pin1, pin2: pin2)
            if validate.error == false{
                return (validate,true)
            }else{
                return (validate,false)
            }
        }else{
            return (Success(message: "Your current pin is wrong", error: true),false)
        }
        
       
    }
    fileprivate func checkPin(pin1:String,pin2:String) async->(Success , Bool){
        let validate = UserPin.validatePin(pin1: pin1, pin2: pin2)
        if validate.error == false{
            return (validate,true)
        }else{
            return (validate,false)
        }
    }
   fileprivate func errorState(msg:String){
        showLoader = false
       self.errorMsg = msg
       self.showMessage = true
    }
    fileprivate  func registerUser() async {
        let arg = ArgumentUserRegistration(applicationID: myData.sahred.appId, deviceName: Theme.DeviceType, firstName: fName, lastName: lName, mobileNumber: myData.sahred.mobileNumber, pin: pin1, emailID: email, ev: "")
        let req = RegisterNew(argument1:arg)
        let handelReq = HandelRegisterRequest()
        
        showLoader = true
        let regReq = await handelReq.registerPin(req: req)
        if regReq.1 {
            let appVersionReq = await handelReq.getAppVersionCode(req: req)
            if appVersionReq.1 {
               // getAppVersion = appVersionReq.2!
                let profileReq = await handelReq.getUserProfile(req: req)
                if profileReq.1 {
                    userProfile = profileReq.2!.result
                    myData.sahred.profile = profileReq.2!.result
                    if ToUserDefaults.removeUserProfileClass() == false{
                        ToUserDefaults.saveUserProfileClass(object: userProfile)
                    }
                     showLoader = false
                   // self.navigateToNext = true
                    if stateManager.stateOfScrren == .Register{
                        stateManager.stateOfScrren = .Login
                    }
                    ToUserDefaults.savePIN(value: pin1)
                    router.path.removeLast(router.path.count)
                   // router.path.append(userProfile)
                }else{
                    showLoader = false
                    errorState(msg: profileReq.0.message)
                }
            }else{
                showLoader = false
                errorState(msg: appVersionReq.0.message)
            }
        }else{
            showLoader = false
            errorState(msg: regReq.0.message)
        }
    }
}

struct SetPin_Previews: PreviewProvider {
    static var previews: some View {
        SetPin(fName:"",lName: "",email: "", changePin: .constant(false))
            .environmentObject(MyLanguage())
            .environmentObject(Router())
            .environmentObject(LaunchScreenStateManager())
    }
}
