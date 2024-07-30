import SwiftUI

struct Clock2View: View {
    @State private var timeString = "04:20"
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black)
            
            Text(timeString)
                .foregroundStyle(.white)
                .font(.displayFont(size: 196))
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
