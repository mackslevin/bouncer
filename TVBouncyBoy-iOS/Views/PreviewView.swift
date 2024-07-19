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
                    Canvas { context, size in
                        // Draw the background rectangle and image
                        if let image = vm.proxyBackgroundImage {
                            context.draw(image, in: CGRect(origin: .zero, size: size))
                        }
                        
                        let rect = CGRect(x: vm.position.x - vm.rectangleSize.width / 2,
                                          y: vm.position.y - vm.rectangleSize.height / 2,
                                          width: vm.rectangleSize.width,
                                          height: vm.rectangleSize.height)
                        
                        if let boxy = context.resolveSymbol(id: 1) {
                            context.draw(boxy, in: rect)
                        }
                    } symbols: {
                        RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                            .overlay {
                                if let boxImg = vm.proxyBoxImage {
                                    boxImg.resizable().scaledToFill()
                                }
                            }
                            .clipped()
                            .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                            .tag(1)
                    }
                    .frame(height: 300)
                    .background {
                        Rectangle()
                            .foregroundStyle(.yellow)
                    }
                    .onAppear {
                        vm.startTimer()
                    }
                    .onDisappear {
                        vm.timer?.invalidate()
                    }
                }
                
                Picker("Background Image", selection: $vm.selectedBackgroundImage) {
                    Text("Choose background...")
                    ForEach(userImages.filter({ $0.imageType == .background })) { bgImage in
                        Text(bgImage.title ?? "Image").tag(bgImage as AppImage?)
                    }
                }
                .padding(.vertical)
                
                Picker("Box Image", selection: $vm.selectedBoxImage) {
                    Text("Choose box image...")
                    ForEach(userImages.filter({ $0.imageType == .boxImage })) { bgImage in
                        Text(bgImage.title ?? "Image").tag(bgImage as AppImage?)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Preview")
            .onAppear {
                vm.containerSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
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
