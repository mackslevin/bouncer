//
//  ContentView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/6/24.
//

import SwiftUI

struct BounceView: View {
    @Bindable var homeVM: TVHomeViewModel
    
    // Proxies for performance. Reading the SwiftData-stored object directly seems to be much more demanding.
    @State private var backgroundImageProxy: Image? = nil
    @State private var boxImageProxy: Image? = nil
    
    @AppStorage(StorageKeys.dimBackground.rawValue) var dimBackground = false
    @AppStorage(StorageKeys.boxShouldHaveShadow.rawValue) var boxShadow = false
    
    var body: some View {
        Button {
            homeVM.isShowingOptions.toggle()
        } label: {
            Canvas { context, size in
                if let bg = context.resolveSymbol(id: 0) {
                    context.draw(bg, in: CGRect(origin: .zero, size: size))
                }
                
                let rect = CGRect(x: homeVM.position.x - homeVM.rectangleSize.width / 2,
                                  y: homeVM.position.y - homeVM.rectangleSize.height / 2,
                                  width: homeVM.rectangleSize.width,
                                  height: homeVM.rectangleSize.height)
                
                if let boxy = context.resolveSymbol(id: 1) {
                    context.draw(boxy, in: rect)
                }
            } symbols: {
                Rectangle()
                    .foregroundStyle(.black)
                    .overlay {
                        ZStack {
                            if homeVM.isLoading {
                                VStack {
                                    Image("logo")
                                        .resizable().scaledToFit()
                                        .frame(width: UIScreen.main.bounds.height/2)
                                    Text("Setting things up...")
                                        .fontDesign(.rounded)
                                }
                                .foregroundStyle(.secondary)
                            } else if let bg = backgroundImageProxy {
                                bg.resizable().scaledToFill()
                                Color.black
                                    .opacity(dimBackground ? 0.5 : 0)
                            }
                        }
                    }
                    .clipped()
                    .tag(0)
                
                Rectangle()
                    .overlay {
                        if let boxImg = boxImageProxy {
                            boxImg.resizable().scaledToFill()
                                .onAppear {
                                    homeVM.isLoading = false
                                }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: Utility.boxCornerRadius))
                    .frame(width: homeVM.rectangleSize.width, height: homeVM.rectangleSize.height)
                    .shadow(radius: boxShadow ? 8 : 0)
                    .tag(1)
                    .opacity(homeVM.isLoading ? 0 : 1)
            }
            .onAppear {
                homeVM.startTimer()
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                homeVM.timer?.invalidate()
            }
        }
        .buttonStyle(BlankButtonStyle())
        .background {
            if let image = backgroundImageProxy {
                image.resizable().scaledToFill()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
        .onAppear {
            backgroundImageProxy = homeVM.backgroundImage?.imageValue
            boxImageProxy = homeVM.boxImage?.imageValue
            homeVM.applyTightening()
        }
        .onChange(of: homeVM.boxImage, { _, newValue in
            boxImageProxy = newValue?.imageValue
        })
        .onChange(of: homeVM.backgroundImage, { oldValue, newValue in
            backgroundImageProxy = newValue?.imageValue
        })
        
    }
    
    
}

#Preview {
    BounceView(homeVM: TVHomeViewModel())
}
