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
                .foregroundStyle(
                    .linearGradient(colors: [.yellow, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .overlay(alignment: .center) {
                    Image("used-to-this")
                        .resizable().scaledToFit()
                        .padding()
                }
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
            CoolBackgroundView(backgroundType: vm.backgroundType)
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
