//
//  ContentView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm = ContentViewModel()
    
    var body: some View {
        Button {
            vm.isShowingOptions.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 3)
                .foregroundStyle(.gray.gradient)
                .overlay(alignment: .center) {
                    vm.boxImage
                        .resizable().scaledToFill()
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
            vm.backgroundImage.resizable().scaledToFill()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
        .onAppear {
            vm.applyTightening()
        }
        .sheet(isPresented: $vm.isShowingOptions, content: {
            OptionsView(contentViewModel: vm)
        })
    }
    
    
}

#Preview {
    ContentView()
}
