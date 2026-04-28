//
//  PagingView.swift
//  TestProj
//
//  Created by Kumar Basant on 07/12/22.
//

import SwiftUI

struct NewPaging:View {
    @State private var currentIndex:Int = 0
    @State private var posts = [OnBoarding]()
    @State var currentTab = "Slide Show"
    @State private var navigateToDash = false
    @EnvironmentObject private var language: MyLanguage
    @EnvironmentObject private var router: Router
   
    var body: some View{
        NavigationStack(path:$router.path){
            ZStack{
                Theme.Primary
                VStack(spacing: 15){
                    VStack(alignment:.leading, spacing: 12){
                       
                        Carousel(index: $currentIndex, items: posts) { post in
                            GeometryReader { proxy in
                                // withAnimation{
                                VStack{
                                    VStack{
                                        if currentIndex == 0{
                                            Image(systemName: "magnifyingglass")
                                                .resizable()
                                               // .scaleEffect(0.88)
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(Theme.OffGray)
                                                .frame(width: 150, height:170)
                                        }else{
                                            Image(post.img)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(currentIndex == 0 ? .gray : Theme.OffGray)
                                               // .frame(width:100, height:120)
                                                .frame(width:150, height:170)
                                        }
                                        
                                    }
                                    .padding(.top,20)
                                    Spacer()
                                    Text(post.heading)
                                        .semiBold(size: 20)
                                       // .font(.title)
                                        .foregroundColor(Theme.Primary)
                                        .padding(.bottom,10)
                                 //   Spacer()
                                    Text(post.descpr)
                                        .medium(size: 18.0)
                                        //.font(.title2)
                                        .foregroundColor(Theme.OffGray)
                                        .padding(.horizontal,25)
                                        .padding(.bottom,25)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .background(RoundedRectangle(cornerRadius: 18.0,style: .continuous).fill(Theme.AppBG))
                                .frame(width: proxy.size.width,height: currentIndex == post.id ? proxy.size.height:proxy.size.height-50)
                                .overlay(RoundedRectangle(cornerRadius: 18.0,style: .continuous).stroke(Theme.Primary,lineWidth: 1.0))
                                .padding(.vertical,currentIndex != post.id ? 30 :0)
                            }
                        }
                    }
                    .frame(maxHeight:.infinity,alignment: .leading)
                    .padding()
                    if currentIndex == 3{
                        VStack{
                            Text("Get_Started".localizableString(language: language.selectedLanguage))
                                .medium(size: 17.0)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150,height: 40)
                        .background(RoundedRectangle(cornerRadius: 12.0,style: .continuous).fill(Theme.Cs_offline_text_color))
                        .onTapGesture {
                            navigateToDash = true
                            router.path.append("ToVerify")
                        }
                    }
                    //Indicator...
                    HStack(alignment:.center,spacing:10){
                        ForEach(posts.indices,id: \.self){ index in
                            Circle()
                                .fill(.white.opacity(currentIndex == index ? 1 : 0.50))
                                .frame(width: 7,height: 7)
                                .scaleEffect(currentIndex == index ? 1 : 0.50)
                                .animation(.spring(),value: currentIndex == index)
                        }
                    }
                    .padding(.bottom,20)
                }
                // .frame(maxHeight:.infinity,alignment: .center)
                .onAppear{
                    // for i in 1...8{
                    posts.removeAll()
                    posts.append(OnBoarding(id: 0, img: "search", heading: "Find_the Nearest_Charging_Station".localizableString(language: language.selectedLanguage), descpr: "paging_Search_Description".localizableString(language: language.selectedLanguage)))
                    posts.append(OnBoarding(id: 1, img: "bookScanPay", heading: "Book,Scan_&_Pay".localizableString(language: language.selectedLanguage), descpr: "paging_Scan_Description".localizableString(language: language.selectedLanguage)))
                    posts.append(OnBoarding(id: 2, img: "car_station", heading: "Charge_&_Go!".localizableString(language: language.selectedLanguage), descpr: "paging_Station_Description".localizableString(language: language.selectedLanguage)))
                    
                    posts.append(OnBoarding(id: 3, img: "reserve", heading: "Reserve_&_Charge!".localizableString(language: language.selectedLanguage), descpr: "Reserve_Descrip!".localizableString(language: language.selectedLanguage)))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self, destination: { values in
                if values == "ToVerify"{
                    VerifyNumber()
                }
                if values == "OtpView"{
                    OtpView(mobileNumber: myData.sahred.mobileNumber,connector:nil,comingFrom: "Register", claculateCharging: "")
                }
                if values == "UserInfoes"{
                    UserInfoes()
                }
                if values == "SetPin"{
                    SetPin(fName:UserInfoes().fName,lName:UserInfoes().lName,email: UserInfoes().email,changePin: .constant(false))
                }
//                if values == "ProfileLinkView"{
//                    ProfileLinkView(user: myData.sahred.profile)
//                }
//                if values == "AboutUsView"{
//                    AboutUsView()
//                }
//                if values == "AboutUsView"{
//                    ContactUsLink()
//                }
//                if values == "ReportIssueLink"{
//                    ReportIssueLink()
//                }
//                if values == "PrivacyPolicyView"{
//                    PrivacyPolicyView()
//                }
//                if values == "SettingViewLink"{
//                    SettingViewLink()
//                }
//                if values == "FaqViewLink"{
//                    FaqViewLink()
//                }
//                if values == "LiveChargingViewLink"{
//                    LiveChargingViewLink()
//                }
            })
            .navigationDestination(for: NavigateToSetPin.self, destination: { value in
                SetPin(fName:value.fName,lName:value.lName,email:value.email,changePin: .constant(false))
            })
            .navigationDestination(for: ResultProfile.self, destination: { value in
                HomeLink(user: value)
            })
            
           
//            .navigationDestination(isPresented: $navigateToDash) {
//                VerifyNumber()
//            }
        }
       
    }
   
}
struct NewPaging_Previews: PreviewProvider {
    static var previews: some View {
        NewPaging()
            .environmentObject(MyLanguage())
            .environmentObject(Router())
    }
}

    //.environmentObject(MyLanguage())
/*struct TabButton:View {
    var title:String
    var animation:Namespace.ID
    @Binding var currentTab:String
    var body: some View{
        Button {
            withAnimation(.spring()) {
                currentTab = title
            }
        } label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(currentTab == title ? .white : .black)
                .frame(maxWidth:.infinity)
                .padding(.vertical,8)
                .background(
                    ZStack{
                        if currentTab == title{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                )
        }

    }
}*/
