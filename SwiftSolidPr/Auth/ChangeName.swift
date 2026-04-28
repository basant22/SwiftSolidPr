//
//  ChangeName.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct ChangeName: View {
    @ObservedObject var viewModel:UserViewModel
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://picsum.photos/200/300")){ image in
                
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(viewModel.name)
            Button("Change Name"){
                viewModel.name = UUID().uuidString
            }
        }
    }
}

struct ChangeName_Previews: PreviewProvider {
    static var previews: some View {
        ChangeName(viewModel: UserViewModel())
    }
}
