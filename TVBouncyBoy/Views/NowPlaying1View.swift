//
//  NowPlaying1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI
import MediaPlayer

struct NowPlaying1View: View {
    @State private var vm = NowPlayingViewModel()
    
    var body: some View {
        ZStack {
            if !vm.someNowPlayingInfoExists() {
                Text("Nothing Playing")
                    .font(.displayFont(size: 34))
            } else {
                
                HStack {
                    if let uiImage = vm.nowPlayingArtwork {
                        Image(uiImage: uiImage).resizable().scaledToFit()
                            .frame(width: 500)
                            .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                    } else {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.secondary)
                            Image(systemName: "music.quarternote.3")
                                .resizable().scaledToFit()
                                .padding(100)
                        }
                        .frame(width: 500, height: 500)
                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(vm.nowPlayingTitle)
                            .font(.displayFont(size: 38))
                        Text(vm.nowPlayingArtist)
                            .fontDesign(.rounded)
                        Text(vm.nowPlayingAlbum)
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    BouncingForegroundView(homeVM: TVHomeViewModel()) {
        NowPlaying1View()
    }
}
