//
//  MyTabs.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct MyTabs: View {
    @State private var selectedTab = 0
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Your Asset color here
        
        // Set the unselected item color
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tabItem {
                    Label(MyConstants.homeString, systemImage: MyConstants.homeIcon)
                }
                
            Text(MyConstants.upcomingString)
                .tabItem {
                    Label(MyConstants.upcomingString, systemImage: MyConstants.upcomingIcon)
                }
            Text(MyConstants.searchString)
                .tabItem {
                    Label(MyConstants.searchString, systemImage: MyConstants.searchIcon)
                }
            Text(MyConstants.downloadString)
                .tabItem {
                    Label(MyConstants.downloadString, systemImage: MyConstants.downloadIcon)
                }
        }
       
       // .accentColor(.borderColor)
        
    }
}

struct MyTabs_Previews: PreviewProvider {
    static var previews: some View {
        MyTabs()
    }
}
