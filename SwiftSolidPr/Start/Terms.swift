//
//  Terms.swift
//  TestProj
//
//  Created by Kumar Basant on 07/12/22.
//

import SwiftUI

struct Terms: View {
    @Binding var isSelected:Bool
    @EnvironmentObject private var language:MyLanguage
    var showTC:()->() = {}
    var body: some View {
        VStack (alignment: .leading){
            HStack(alignment:.center){
                Image(systemName: isSelected ? "checkmark.square" : "square")
                    .onTapGesture {
                        isSelected.toggle()
                    }
                    .padding(.leading,5)
                Text("By Proceeding you are agree to our-".localizableString(language: language.selectedLanguage))
            }
            VStack{
                Text("Terms & Conditions".localizableString(language: language.selectedLanguage))
                    .unredacted()
                    .foregroundColor(Theme.VoltticColor)
                    .padding(.leading,10)
                    .padding(.top,1)
                    .onTapGesture {
                        showTC()
                    }
                Text("Privacy & Policy".localizableString(language: language.selectedLanguage))
                    .unredacted()
                    .foregroundColor(Theme.VoltticColor)
                    .padding(.leading,8)
                    .padding(.top,1)
                    .onTapGesture {
                        showTC()
                    }
            }
            Spacer()
        }
        .padding(.leading,20)
        .padding(.top,20)
    }
}

struct Terms_Previews: PreviewProvider {
    static var previews: some View {
        Terms(isSelected: .constant(false))
            .environmentObject(MyLanguage())
    }
}
