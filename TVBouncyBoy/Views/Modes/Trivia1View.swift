//
//  Trivia1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/6/24.
//

import SwiftUI



struct Trivia1View: View {
    @State private var vm = TriviaViewModel()

    
    @State private var bgColor = Color.black
    @State private var fgColor = Color.white
    
    var body: some View {
        ZStack {
                Rectangle().foregroundStyle(bgColor.gradient)
                
                VStack {
                    if vm.trivia == nil {
                        Image(systemName: "questionmark.circle.fill")
                    } else {
                        Text(vm.trivia!)
                            .foregroundStyle(fgColor)
                            .padding()
                            .minimumScaleFactor(0.01)
                    }
                }
        }
        .onAppear {
            Task {
                await vm.requestToken()
            }
        }
        .onDisappear {
            vm.stopTimer()
        }
        .onChange(of: vm.trivia) { oldValue, newValue in
            // Swap background and foreground colors when we get a new trivia string. (Make it noticeable something changed.)
            if fgColor == .white { fgColor = .black } else { fgColor = .white }
            if bgColor == .white { bgColor = .black } else { bgColor = .white }
        }
    }
}





#Preview {
    Trivia1View()
}
