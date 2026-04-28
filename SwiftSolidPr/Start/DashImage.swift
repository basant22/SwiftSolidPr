//
//  DashImage.swift
//  Volttic
//
//  Created by ShwetJ on 13/12/22.
//

import SwiftUI

struct DashImage: View {
    var img:String
    var menuName:String
    @EnvironmentObject private var language: MyLanguage

    var body: some View {
        VStack{
            Image(systemName: img)
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 60)
                .foregroundColor(Theme.Primary)
            Text(menuName.localizableString(language: language.selectedLanguage))
               // .frame(width: 100,height: 40)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .font(.system(size: 13,weight: .regular))
            Divider()
                .background(Theme.TextGray)
                .padding(.top,15)
                .padding(.horizontal,20)
        }
        .padding(.horizontal,0)
    }
}

struct DashImage_Previews: PreviewProvider {
    static var previews: some View {
        DashImage(img: "", menuName: "")
            .environmentObject(MyLanguage())
    }
        
}
