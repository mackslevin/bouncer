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
    
    @State private var isShowingBackgroundChooser = false
    @State private var isShowingBoxImageChooser = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                        Canvas { context, size in
                            if let bg = context.resolveSymbol(id: 0) {
                                context.draw(bg, in: CGRect(origin: .zero, size: size))
                            }
                            
                            let rect = CGRect(x: vm.position.x - vm.rectangleSize.width / 2,
                                              y: vm.position.y - vm.rectangleSize.height / 2,
                                              width: vm.rectangleSize.width,
                                              height: vm.rectangleSize.height)
                            
                            if let boxy = context.resolveSymbol(id: 1) {
                                context.draw(boxy, in: rect)
                            }
                        } symbols: {
                            Rectangle()
                                .foregroundStyle(.gray)
                                .overlay {
                                    if let boxImg = vm.proxyBoxImage {
                                        boxImg.resizable().scaledToFill()
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: Utility.boxCornerRadius / 4))
                                .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                                .tag(1)
                            
                            if let bg = vm.proxyBackgroundImage {
                                Rectangle()
                                    .overlay {
                                        bg.resizable().scaledToFill()
                                    }
                                    .tag(0)
                                
                        }
                    }
                    .background {
                        Rectangle()
                            .foregroundStyle(Color.primary.gradient)
                    }
                    .frame(height: vm.containerSize.height)
                    .onAppear {
                        vm.startTimer()
                    }
                    .onDisappear {
                        vm.timer?.invalidate()
                    }
                }
                .frame(height: vm.containerSize.height)
                
                HStack(spacing: 18) {
                    Button {
                        isShowingBackgroundChooser.toggle()
                    } label: {
                        VStack {
                            Text("Background")
                                .font(Font.displayFont(size: 15))
                            Rectangle()
                                .overlay {
                                    if let bg = vm.proxyBackgroundImage {
                                        bg.resizable().scaledToFill()
                                    } else {
                                        Image(systemName: "photo")
                                            .font(.title)
                                            .fontWeight(.thin)
                                            .foregroundStyle(.primary).colorInvert()
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                        }
                    }
                    .tint(.primary)
                    
                    Button {
                        isShowingBoxImageChooser.toggle()
                    } label: {
                        VStack {
                            Text("Bouncing Image")
                                .font(Font.displayFont(size: 15))
                            Rectangle()
                                .overlay {
                                    if let bg = vm.proxyBoxImage {
                                        bg.resizable().scaledToFill()
                                    } else {
                                        Image(systemName: "photo")
                                            .font(.title)
                                            .fontWeight(.thin)
                                            .foregroundStyle(.primary).colorInvert()
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                        }
                    }
                    .tint(.primary)
                }
                .padding()
                .frame(height: 170)
                
                Spacer()
            }
            .navigationTitle("Preview")
            .onAppear {
                vm.containerSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
            }
            .onChange(of: vm.selectedBackgroundImage) { _, newValue in
                if let imageValue = newValue?.imageValue {
                    vm.proxyBackgroundImage = imageValue
                } else {
                    vm.proxyBackgroundImage = nil
                }
            }
            .onChange(of: vm.selectedBoxImage) { _, newValue in
                if let imageValue = newValue?.imageValue {
                    vm.proxyBoxImage = imageValue
                } else {
                    vm.proxyBoxImage = nil
                }
            }
            .sheet(isPresented: $isShowingBackgroundChooser, content: {
                AppImageChooser(previewVM: vm, imageType: .background)
            })
            .sheet(isPresented: $isShowingBoxImageChooser, content: {
                AppImageChooser(previewVM: vm, imageType: .boxImage)
            })
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
