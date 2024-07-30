//
//  ModeButtonLabel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/29/24.
//

import SwiftUI

struct BackgroundModeButtonLabel<Content: View>: View {
    @Bindable var homeVM: TVHomeViewModel
    let mode: BackgroundMode
    let content: Content
    
    
    @State private var spinning = false
    
    init(homeVM: TVHomeViewModel, mode: BackgroundMode, @ViewBuilder content: () -> Content) {
        self.homeVM = homeVM
        self.mode = mode
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: Utility.tvAppOptionsButtonHeight)
                .foregroundStyle(.accent.gradient)
                .overlay {
                    content
                        .aspectRatio(16/9, contentMode: .fill)
                }
                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
        }
        .overlay {
            ZStack {
                Color.black.opacity(0.5)
                Image(systemName: "checkmark.circle.fill").resizable().scaledToFit()
                    .frame(height: Utility.tvAppOptionsButtonHeight * 0.6)
                    .foregroundStyle(.white)
                    .shadow(radius: 4)
            }
            .opacity(homeVM.backgroundMode == mode ? 1 : 0)
        }
    }
}

//#Preview {
//    ModeButtonLabel(content: {Text("Hello")})
//}
