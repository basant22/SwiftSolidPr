//
//  Carousel.swift
//  Volttic
//
//  Created by ShwetJ on 10/02/23.
//

import SwiftUI

struct Carousel<Content:View,T:Identifiable>:View {
    var content:(T) -> Content
    var list:[T]
    //properties
    var spacing:CGFloat
    var trailingSpace:CGFloat
    @Binding var index : Int
    
    init(spacing:CGFloat = 10,trailingSpace:CGFloat = 50,index:Binding<Int>,items:[T],@ViewBuilder content:@escaping (T)->Content){
        self._index = index
        self.list = items
        self.trailingSpace = trailingSpace
        self.spacing = spacing
        self.content = content
    }
    @GestureState var offset:CGFloat = 0
    @State var currentIndex:Int = 0
    var body: some View{
        GeometryReader { proxy in
            //setting correct width for carousal
            //let width = proxy.size.width - (trailingSpace - spacing)
            let width = proxy.size.width - (trailingSpace)
           // let height = currentIndex == index ? proxy.size.height : (proxy.size.height-30)
            
          //  let adjustWidth = (trailingSpace/2) - spacing
            HStack(spacing:spacing){
                ForEach(list){ item in
                    content(item)
                        .frame(width: width)
                }
            }
           // .padding(.leading,offset+spacing/2)
            //setting only after oth index
            .offset(x:(CGFloat(currentIndex) * -width) + offset + (CGFloat(currentIndex) * -spacing) +  CGFloat(trailingSpace/2) )
           // .offset(x:(CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustWidth : 0) + offset)
            .gesture(
            DragGesture()
                .updating($offset, body: { value, out, _ in
                   // withAnimation(.spring(blendDuration: 0.83)) {
                        out = value.translation.width
                   // }
                    
                })
                .onEnded({ value in
                   // withAnimation {
                        
                        
                        //updating current index
                        let offset = value.translation.width
                        //going to convert the tranlation into progress (0 - 1)
                        //and round the value
                        //based on the progress increasing or decreasing the currentIndex
                        let progress = -offset/width
                        let roundIndex = progress.rounded()
                        // setting max
                        currentIndex =  max(min(currentIndex + Int(roundIndex),list.count-1),0)
                        //updating index
                    withAnimation(.easeIn(duration: 0.42)) {
                        currentIndex = index
                    }
                })
                .onChanged({ value in
                    //updating only index
                  //  withAnimation {
                        
                    
                    let offset = value.translation.width
                    //going to convert the tranlation into progress (0 - 1)
                    //and round the value
                    //based on the progress increasing or decreasing the currentIndex
                    let progress = -offset/width
                    let roundIndex = progress.rounded()
                    // setting max
                    index =  max(min(currentIndex + Int(roundIndex),list.count-1),0)
               // }
                })
            )
        }
        //.animation(.easeIn(duration:0.25))
        //.animation(.easeIn, value: currentIndex == index)
        //Spacing will be horizintal padding
        
    }
}
struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct Carousel_Previews: PreviewProvider {
//    static var previews: some View {
//        Carousel()
//    }
//}
