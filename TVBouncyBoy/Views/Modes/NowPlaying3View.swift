//
//  NowPlaying3View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/27/24.
//

import SwiftUI

struct NowPlaying3View: View {
    @State private var vm = NowPlayingViewModel()
    var body: some View {
        if !vm.someNowPlayingInfoExists() {
            NothingPlayingView()
        } else {
            ZStack {
                if let uiImage = vm.nowPlayingArtwork {
                    Rectangle()
                        .overlay {
                            Image(uiImage: uiImage).resizable().scaledToFill()
                        }
                    Rectangle().foregroundStyle(Material.ultraThin)
                } else {
                    Rectangle()
                        .foregroundStyle(
                            LinearGradient(colors: [.accent, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Text(vm.nowPlayingTitle)
                            .font(.displayFont(size: min(geometry.size.width, geometry.size.height) * 0.5))
                            .minimumScaleFactor(0.1)
                            .frame(height: geometry.size.height, alignment: .center)
                            .lineLimit(1)
                    }
                    
                    GeometryReader { geometry in
                        Text(vm.nowPlayingArtist)
                            .font(.displayFont(size: min(geometry.size.width, geometry.size.height) * 0.5))
                            .minimumScaleFactor(0.1)
                            .frame(height: geometry.size.height, alignment: .center)
                            .lineLimit(1)
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    NowPlaying3View()
}
