//
//  RunLoopView.swift
//  SwiftSolidPr
//
//  Created by apple on 14/05/26.
//

import SwiftUI

struct RunLoopView: View {
    @StateObject private var viewModal = ContentViewModel()
    var body: some View {
        ScrollView{
            VStack{
                Group{
                    if let data = viewModal.imagedata , let uiimage = UIImage(data:data){
                        Image(uiImage:uiimage)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           
                   }else if viewModal.isLoading{
                       ProgressView()
                   }
                }
            }
            VStack{
                Text("Default Timer=\(viewModal.defaultTmer)")
                Text("Common Timer=\(viewModal.commonTimer)")
            }
        }
    }
}

struct RunLoopView_Previews: PreviewProvider {
    static var previews: some View {
        RunLoopView()
    }
}
