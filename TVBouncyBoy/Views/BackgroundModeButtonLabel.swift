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
                .frame(height: 150)
                .foregroundStyle(.accent.gradient)
                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
            
            content
        }
        .overlay {
            ZStack {
                Color.black.opacity(0.5)
                Image(systemName: "checkmark.circle.fill").resizable().scaledToFit()
                    .frame(height: 150 * 0.6)
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
