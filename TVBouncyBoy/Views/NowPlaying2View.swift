//
//  NowPlaying2View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/27/24.
//

import SwiftUI

struct NowPlaying2View: View {
    @State private var vm = NowPlayingViewModel()
    
    
    var body: some View {
        if !vm.someNowPlayingInfoExists() {
            NothingPlayingView()
                
        } else {
            
            ZStack {
                if let uiImage = vm.nowPlayingArtwork {
                    Image(uiImage: uiImage).resizable().scaledToFill()
                    Rectangle().foregroundStyle(Material.ultraThin)
                } else {
                    LinearGradient(colors: [.accent, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                        .foregroundStyle(
                            LinearGradient(colors: [.accent, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .overlay(content: {
                            if let uiImage = vm.nowPlayingArtwork {
                                Image(uiImage: uiImage).resizable().scaledToFill()
                            } else {
                                Image(systemName: "music.quarternote.3").resizable().scaledToFit()
                                    .foregroundStyle(.white)
                                    .padding(100)
                            }
                        })
                        .aspectRatio(1, contentMode: .fit)
                        .shadow(radius: 10, x: 2, y: 2)
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.75)
                    
                    VStack {
                        Text(vm.nowPlayingTitle)
                        Text(vm.nowPlayingArtist)
                    }
                    .font(.displayFont(size: 32))
                }
                .padding()
            }
        }
    }
}

#Preview {
    NowPlaying2View()
}
