//
//  NowPlaying1PreviewView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/30/24.
//

import SwiftUI
import MediaPlayer


struct NowPlaying2PreviewView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(Color.accent.gradient)
            
            VStack(spacing: 8) {
                Rectangle()
                    .foregroundStyle(Color.accent.gradient)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: Utility.tvAppOptionsButtonHeight * 0.65)
                    .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                    .shadow(radius: 5)
                
                VStack(alignment: .center, spacing: 4) {
                    Rectangle()
                        .frame(width: 80, height: 4)
                    Rectangle()
                        .frame(width: 50, height: 4)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    BouncingForegroundView(homeVM: TVHomeViewModel()) {
        NowPlaying2PreviewView()
    }
}
