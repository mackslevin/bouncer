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
                    Label("Upload", systemImage: "photo")
                }
                
            
            PreviewView()
                .tabItem {
                    Label("Preview", systemImage: "play.tv")
                }
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "SpaceGrotesk-Bold", size: 33)!]
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "SpaceGrotesk-Bold", size: 18)!]
        }
    }
}

#Preview {
    HomeView()
}
