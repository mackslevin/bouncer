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
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.accent]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.accent]
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    HomeView()
}
