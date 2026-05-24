//
//  NetworkAwareModifier.swift
//  SwiftSolidPr
//
//  Created by apple on 06/05/26.
//

import Foundation
import SwiftUI

struct NetworkAwareModifier:ViewModifier{
   // typealias Body = <#type#>
    @StateObject private var network = NetworkMonitor()
   
    func body(content: Content) -> some View {
        VStack{
            content
            if !network.isConnected{
                OfflineBannerView()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: network.isConnected)
       // .animation(.default,value: network.isConnected)
    }
}

extension View{
    func monitorNetwork()-> some View{
        self.modifier(NetworkAwareModifier())
    }
}
