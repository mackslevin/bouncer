import SwiftUI

struct NowPlayingForeground1: View {
    @State private var npvm = NowPlayingViewModel()
    
    var body: some View {
        ZStack {
            ZStack {
                if let uiImage = npvm.nowPlayingArtwork {
                    Image(uiImage: uiImage).resizable().scaledToFill()
                }
                
                Rectangle()
                    .foregroundStyle(.regularMaterial)
            }
            
            
            if !npvm.someNowPlayingInfoExists() {
                NothingPlayingView()
            } else {
                VStack {
                    Text("\"\(npvm.nowPlayingTitle)\"")
                        .font(.displayFont(size: 32))
                    Text(npvm.nowPlayingArtist)
                    Text(npvm.nowPlayingAlbum)
                        .italic()
                }
                .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            
        }
        .onDisappear {
            
        }
    }
    
    
}
