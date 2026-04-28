//
//  IconTextModifiers.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import Foundation
import SwiftUI
struct IconTextModifiers:ViewModifier {
    var systemImage:String?
    var isSecureFields:Bool? = false
    @Binding var isVisible:Bool
    func body(content: Content) -> some View {
        HStack(){
            Image(systemName: systemImage ?? "")
                .frame(width: 20, height: 20)
                .foregroundColor(Color.gray)
                .padding(.leading,10)
            content
                .padding()
                .frame(height: 54)
            if let isSecure = isSecureFields, isSecure == true {
                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.gray)
                        .padding(.trailing,10)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black,lineWidth: 1.0)
        )
    }
}


