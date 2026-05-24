//
//  CustomImgCell.swift
//  SwiftSolidPr
//
//  Created by apple on 15/05/26.
//

import SwiftUI

struct CustomImgCell: View {
    @StateObject private var viewModel:LoadImageViewModel
    let urL:URL
    init(urL:URL,service:CachedImageProtocol){
        self.urL = urL
        _viewModel = StateObject(wrappedValue:LoadImageViewModel(objCache: service))
    }
    var body: some View {
        Group{
            if viewModel.image.size.width > 0{
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.2))
                    .overlay {
                        ProgressView()
                    }
                   // .aspectRatio(1, contentMode: .fit)
            }
        }
        .frame(minWidth:0,maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit) // Keep it square
        .task {
           try? await viewModel.loadImage(url: self.urL)
        }
        
      
    }
}


