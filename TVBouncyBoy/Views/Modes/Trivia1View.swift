//
//  Trivia1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/6/24.
//

import SwiftUI



struct Trivia1View: View {
    @State private var vm = TriviaViewModel()
    
    
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(Color.white.gradient)
            
            VStack {
                Text(vm.trivia ?? "N/A")
                    .foregroundStyle(.accent)
                    .padding()
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
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
    }
}





#Preview {
    Trivia1View()
}
