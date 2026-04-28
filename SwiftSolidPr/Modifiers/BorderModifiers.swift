//
//  BorderModifiers.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import Foundation
import SwiftUI

struct BorderStyle:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black,lineWidth: 1.0)
            )
            .frame(height: 54)
    }
}
extension View{
    func blackBorder() -> some View{
        self.modifier(BorderStyle())
    }
    func textIcon(systemImage:String? = "",isSecure:Bool? = false,isVisible:Binding<Bool>)-> some View{
        self.modifier(IconTextModifiers(systemImage: systemImage,isSecureFields: isSecure, isVisible: isVisible))
    }
}
