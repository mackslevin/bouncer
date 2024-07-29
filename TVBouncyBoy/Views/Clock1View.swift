//
//  Clock1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/29/24.
//

import SwiftUI

struct Clock1View: View {
    @State private var timeString = "04:20"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white)
            
            Text(timeString)
                .foregroundStyle(.black)
                .font(.displayFont(size: 196))
                .minimumScaleFactor(0.1)
                .padding()
        }
        .onAppear {
            timeString = Utility.simpleFormattedTime()
            startTimer()
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeString = Utility.simpleFormattedTime()
        }
    }
}

#Preview {
    Clock1View()
}
