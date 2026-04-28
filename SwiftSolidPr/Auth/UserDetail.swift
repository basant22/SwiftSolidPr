//
//  UserDetail.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct UserDetail: View {
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://picsum.photos/200/300")){ image in
                
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
              ProgressView()
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("User Detail")
        .navigationBarTitleDisplayMode(.inline)
       // .toolbar(.hidden, for: .navigationBar)
       // .navigationBarHidden(true)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDetail()
    }
}
