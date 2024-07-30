//
//  NowPlaying1PreviewView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/30/24.
//

import SwiftUI
import MediaPlayer

// Minimal. Text and album cover only, black background.
struct NowPlaying1PreviewView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(Color.black.gradient)
            
            HStack(spacing: 8) {
                Rectangle()
                    .foregroundStyle(Color.accent.gradient)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: Utility.tvAppOptionsButtonHeight / 3.5)
                    .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Rectangle()
                        .frame(width: 80, height: 4)
                    Rectangle()
                        .frame(width: 50, height: 4)
                    Rectangle()
                        .frame(width: 60, height: 4)
                }
                
            }
            .padding()
        }

//        .frame(height: Utility.tvAppOptionsButtonHeight)
    }
}

#Preview {
    BouncingForegroundView(homeVM: TVHomeViewModel()) {
        NowPlaying1PreviewView()
    }
}
