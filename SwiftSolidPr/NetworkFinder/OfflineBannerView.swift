//
//  OfflineBannerView.swift
//  SwiftSolidPr
//
//  Created by apple on 06/05/26.
//

import SwiftUI

struct OfflineBannerView: View {
    let message:String = "No Internet Connection"
    var body: some View {
       
            HStack{
                Image(systemName: "wifi.exclamationmark")
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    
            }
            .foregroundColor(.white)
            .frame(maxWidth:.infinity)
            .frame(height:50)
            .background(Color.red)
            .padding(.horizontal)
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    
}

struct OfflineBannerView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineBannerView()
    }
}
