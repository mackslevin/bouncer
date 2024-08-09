//
//  ColorGrad6View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/8/24.
//

import SwiftUI

struct ColorGrad6View: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.red)
            Rectangle()
                .foregroundStyle(.black)
                .padding(10)
                .blur(radius: 50)
        }
    }
}

#Preview {
    ColorGrad6View()
}
