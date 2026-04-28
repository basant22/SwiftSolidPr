//
//  ImageSliderView.swift
//  SwiftSolidPr
//
//  Created by apple on 02/04/26.
//

import SwiftUI

struct ImageSliderView: View {
    let images = ["Image1", "Image2", "Image3", "Image4"] // Names from Assets

    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: geometry.size.height * 0.95)
                        //.clipped()
                }
            }
            .frame(height: geometry.size.height)
            .tabViewStyle(.page) // This enables the horizontal sliding "snap"
            .indexViewStyle(.page(backgroundDisplayMode: .always)) // Shows the dots
        }
        
    }
}
