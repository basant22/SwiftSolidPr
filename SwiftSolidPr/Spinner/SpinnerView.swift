//
//  SpinnerView.swift
//  SwiftSolidPr
//
//  Created by apple on 02/05/26.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        VStack{
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading Patient Text..")
                .foregroundColor(.gray)
                .padding(.top,10)
        }
        .frame(maxWidth:.infinity)
        .padding(.vertical,40)
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
