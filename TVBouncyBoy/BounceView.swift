//
//  ContentView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/6/24.
//

import SwiftUI

struct BounceView: View {
    @State var vm = BounceViewModel()
    
    // Proxies for performance. Reading the SwiftData-stored object directly seems to be much more demanding.
    @State private var backgroundImageProxy: Image? = nil
    @State private var boxImageProxy: Image? = nil
    
    
//    @AppStorage(StorageKeys.currentBackgroundID.rawValue) var bgID: String = ""
//    @AppStorage(StorageKeys.currentBoxImageID.rawValue) var boxID: String = ""
    
    
    
    var body: some View {
        Button {
            vm.isShowingOptions.toggle()
        } label: {
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
                        if let bg = backgroundImageProxy {
                            bg.resizable().scaledToFill()
                        }
                    }
                    .clipped()
                    .tag(0)
                
                Rectangle()
                    .overlay {
                        if let boxImg = boxImageProxy {
                            boxImg.resizable().scaledToFill()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: Utility.boxCornerRadius))
                    .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                    .tag(1)
            }
            .onAppear {
                vm.startTimer()
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                vm.timer?.invalidate()
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
            backgroundImageProxy = vm.backgroundImage?.imageValue!
            boxImageProxy = vm.boxImage?.imageValue
            
            vm.applyTightening()
        }
        .onChange(of: vm.boxImage, { _, newValue in
            boxImageProxy = newValue?.imageValue!
        })
        .onChange(of: vm.backgroundImage, { oldValue, newValue in
            backgroundImageProxy = newValue?.imageValue!
        })
//        .onChange(of: bgID, { oldValue, newValue in
//            Task {
//                vm.backgroundImage = try? DataManager.shared.allUserImages().first(where: {$0.id.uuidString == newValue})
//            }
//        })
//        .onChange(of: boxID, { oldValue, newValue in
//            Task {
//                vm.boxImage = try? DataManager.shared.allUserImages().first(where: {$0.id.uuidString == newValue})
//            }
//        })
        .sheet(isPresented: $vm.isShowingOptions, content: {
            OptionsView(contentViewModel: vm)
        })
    }
    
    
}

#Preview {
    BounceView()
}
