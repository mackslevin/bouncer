//
//  Clock6View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 9/12/24.
//

import SwiftUI

struct Clock6View: View {
    @State private var timeString = "04:20"
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black)
            
            Text(timeString)
                .foregroundStyle(.white)
                .fontDesign(.serif)
                .fontWeight(.black)
                .font(.system(size: 196))
                .minimumScaleFactor(0.1)
                .padding()
                .aspectRatio(16/9, contentMode: .fill)
        }
        .onAppear {
            timeString = Utility.simpleFormattedTime()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeString = Utility.simpleFormattedTime()
        }
    }
}

#Preview {
    Clock6View()
}
