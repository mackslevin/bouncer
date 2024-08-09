//
//  ColorGrad4View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/8/24.
//

import SwiftUI

struct ColorGrad4View: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                LinearGradient(colors: [.teal, .mint, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
    }
}

#Preview {
    ColorGrad4View()
}
