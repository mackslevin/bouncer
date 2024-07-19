//
//  ContentView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm = ContentViewModel()
    
    // Proxies for performance. Reading the SwiftData-stored object directly seems to be much more demanding.
    @State private var backgroundImageProxy: Image? = nil
    @State private var boxImageProxy: Image? = nil
    
    var body: some View {
        Button {
            vm.isShowingOptions.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 3)
                .foregroundStyle(.gray.gradient)
                .overlay(alignment: .center) {
                    if let image = boxImageProxy {
                        image
                            .resizable().scaledToFill()
                    }
                }
                .clipped()
                .frame(width: vm.rectangleSize.width, height: vm.rectangleSize.height)
                .position(vm.position)
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
            backgroundImageProxy = vm.backgroundImage.imageValue!
            boxImageProxy = vm.boxImage.imageValue!
            
            vm.applyTightening()
        }
        .onChange(of: vm.boxImage, { _, newValue in
            boxImageProxy = newValue.imageValue!
        })
        .onChange(of: vm.backgroundImage, { oldValue, newValue in
            backgroundImageProxy = newValue.imageValue!
        })
        .sheet(isPresented: $vm.isShowingOptions, content: {
            OptionsView(contentViewModel: vm)
        })
    }
    
    
}

#Preview {
    ContentView()
}
