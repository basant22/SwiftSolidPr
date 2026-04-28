//
//  HomeView.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: MyConstants.testUrl1)){ image in
                image
                    .resizable()
                   // .scaledToFit()
                    
            } placeholder: {
                ProgressView()
            }
            HStack{
                Button{
                    
                }label: {
                    Text(MyConstants.playSting)
                        .ghostButton()
                }
                
                Button{
                    
                }label: {
                    Text(MyConstants.downloadString)
                        .ghostButton()
                }
            }
            .padding(.bottom,20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
