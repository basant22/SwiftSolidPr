//
//  GridView.swift
//  SwiftSolidPr
//
//  Created by apple on 14/05/26.
//

import SwiftUI
struct ImageSource:Identifiable{
    var id:Int
    var imageUrl:String
    var isSelected = false
}
struct PhotoGridView: View {
    var imageNames: [ImageSource] = (1...10).map { ImageSource(id: $0, imageUrl: "https://picsum.photos/300/300") } // replace with your asset names
    // let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    let columns = [GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 8)]
    // var viewModal = LoadImageViewModel(objCache: CachedImage())
    var viewModal = GalleryViewModel(objCache: CachedImage())
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(imageNames) { item in
                    if let url = URL(string: item.imageUrl){
                        renderCell(url: url)
                            .task {
                                try? await viewModal.loadImage(url: url)
                            }
                      }
                    //  CustomImgCell(urL: URL(string: item.imageUrl)!, service: CachedImage())
                    /*  AsyncImage(url: URL(string: item.imageUrl)) { image in
                     image
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(minWidth: 0, maxWidth: .infinity)
                     .aspectRatio(1, contentMode: .fit) // Keep it square
                     .cornerRadius(10)
                     .onTapGesture {
                     // item.isSelected.toggle()
                     }
                     } placeholder: {
                     RoundedRectangle(cornerRadius: 12)
                     .fill(Color.green.opacity(0.2))
                     .overlay {
                     ProgressView()
                     }
                     .aspectRatio(1, contentMode: .fit)
                     
                     }*/
                }
            }
            .padding(8)
        }
    }
    
    @ViewBuilder
    private func renderCell(url:URL)-> some View{
        Group{
            if let img = viewModal.downloadImage[url]{
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.2))
                    .overlay {
                        if viewModal.isLoading[url] == true{
                            ProgressView()
                        }
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .clipped()
        .cornerRadius(10)
    }
    
}

