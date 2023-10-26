//
//  ContentView.swift
//  train-window-app
//
//  Created by yuuta on 2023/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabItem = .homePage
    
    enum TabItem {
        case homePage
        case mapPage
        case sharePage
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomePageView()
                .tabItem {
                    Label("ホーム", systemImage: "star")
                }
                .tag(TabItem.homePage)
            MapPageView()
                .tabItem {
                    Label("マップ", systemImage: "star")
                }
                .tag(TabItem.mapPage)
            SharePageView()
                .tabItem {
                    Label("シェア", systemImage: "star")
                }
                .tag(TabItem.sharePage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
