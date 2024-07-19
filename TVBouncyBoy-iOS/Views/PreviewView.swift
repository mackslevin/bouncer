//
//  PreviewView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct PreviewView: View {
    @State private var vm = PreviewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        Rectangle()
                        
                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .position(vm.position)
                            .onAppear {
                                vm.startTimer()
                            }
                            .onDisappear {
                                vm.timer?.invalidate()
                            }
                    }
                }
                .frame(height: 300)
                
                
                
                Spacer()
            }
            .navigationTitle("Preview")
            .onAppear {
                vm.containerSize = CGSize(width: UIScreen.main.bounds.width, height: 300
                )
            }
        }
        
    }
}

#Preview {
    TabView {
        PreviewView()
            .tabItem {
                Label("Preview", systemImage: "play.tv")
            }
        ContentView()
            .tabItem {
                Label("Images", systemImage: "photo")
            }
    }
}
