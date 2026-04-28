//
//  Tabs.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct Tabs: View {
    @State private var selectedTab = 0
        
        var body: some View {
            VStack(spacing: 0) {
                // Main Content Area
                ZStack {
                    switch selectedTab {
                    case 0: HomeView()
                    case 1: ImageSliderView()
                    case 2: Text("Search")
                    default: Text("Download")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Custom Tab Bar
                HStack {
                    TabButton(index: 0, icon: MyConstants.homeIcon, label: MyConstants.homeString, selected: $selectedTab)
                    TabButton(index: 1, icon: MyConstants.upcomingIcon, label: MyConstants.upcomingString, selected: $selectedTab)
                    TabButton(index: 2, icon: MyConstants.searchIcon, label: MyConstants.searchString, selected: $selectedTab)
                    TabButton(index: 3, icon: MyConstants.downloadIcon, label: MyConstants.downloadString, selected: $selectedTab)
                }
                .frame(height: 70) // Custom height
                .background(.white)
                .shadow(color: .borderColor.opacity(0.4), radius: 5, x: 0, y: -2)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
