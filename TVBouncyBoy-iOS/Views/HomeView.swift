//
//  HomeView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Images", systemImage: "photo")
                }
            
            PreviewView()
                .tabItem {
                    Label("Preview", systemImage: "play.tv")
                }
        }
    }
}

#Preview {
    HomeView()
}
