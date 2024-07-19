//
//  PreviewView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData

struct PreviewView: View {
    @State private var vm = PreviewViewModel()
    @Query private var userImages: [AppImage]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .overlay {
                                if let image = vm.proxyBackgroundImage {
                                    image.resizable().scaledToFill()
                                }
                            }
                        
                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .overlay {
                                if let image = vm.proxyBoxImage {
                                    image.resizable().scaledToFill()
                                }
                            }
                            .clipped()
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
                
                Picker("Background Image", selection: $vm.selectedBackgroundImage) {
                    Text("Choose background...")
                    ForEach(userImages.filter({$0.imageType == .background})) { bgImage in
                        Text(bgImage.title ?? "Image").tag(bgImage as AppImage?)
                    }
                }
                .padding(.vertical)
                
                Picker("Box Image", selection: $vm.selectedBoxImage) {
                    Text("Choose box image...")
                    ForEach(userImages.filter({$0.imageType == .boxImage})) { bgImage in
                        Text(bgImage.title ?? "Image").tag(bgImage as AppImage?)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Preview")
            .onAppear {
                vm.containerSize = CGSize(width: UIScreen.main.bounds.width, height: 300
                )
            }
            .onChange(of: vm.selectedBackgroundImage) { _, newValue in
                if let imageValue = newValue?.imageValue {
                    vm.proxyBackgroundImage = imageValue
                }
            }
            .onChange(of: vm.selectedBoxImage) { _, newValue in
                if let imageValue = newValue?.imageValue {
                    vm.proxyBoxImage = imageValue
                }
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
