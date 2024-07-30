import SwiftUI
import MediaPlayer

struct NowPlaying3PreviewView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(Color.accent.gradient)
            
            
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Rectangle()
                        .frame(height: Utility.tvAppOptionsButtonHeight/4)
                        .padding(.trailing, 10)
                    Spacer()
                    Rectangle()
                        .frame(height: Utility.tvAppOptionsButtonHeight/4)
                        .padding(.trailing, 40)
                }
                .padding(20)
                
            
        }
    }
}

#Preview {
    BouncingForegroundView(homeVM: TVHomeViewModel()) {
        NowPlaying3PreviewView()
    }
}
