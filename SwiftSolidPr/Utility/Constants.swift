//
//  Constants.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import Foundation
import SwiftUI
struct MyConstants{
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playSting = "Play"
    static let trendingTVString = "Treading TV"
    static let trendingMovieString = "Treading Movie"
    
    static let homeIcon = "house.circle"
    static let upcomingIcon = "play.circle"
    static let searchIcon = "magnifyingglass.circle"
    static let downloadIcon = "arrow.down.to.line.circle"
    
    static let testUrl1 = "https://picsum.photos/200/300"
    static let testUrl2 = "https://picsum.photos/300/200"
    static let testUrl3 = "https://picsum.photos/300/200"
}

extension ShapeStyle where Self == Color {
    static var borderColor: Color { Color("BorderColor") }
    static var buttonTextColor: Color { Color("ButtonTextColor") }
}
extension Text{
    func ghostButton()->some View{
        self
            .frame(width:120,height: 45)
            .foregroundColor(.buttonTextColor)
            .background(
                RoundedRectangle(cornerRadius: 12,style: .continuous)
                    .stroke(.borderColor,lineWidth: 1.0)
            )
    }
}
