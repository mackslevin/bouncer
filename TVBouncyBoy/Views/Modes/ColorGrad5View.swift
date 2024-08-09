//
//  ColorGrad5View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/8/24.
//

import SwiftUI

struct ColorGrad5View: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                LinearGradient(colors: [
                    Color(red: 239/255, green: 71/255, blue: 111/255),
                    Color(red: 255/255, green: 209/255, blue: 102/255)
                ], startPoint: .bottomLeading, endPoint: .topTrailing)
            )
    }
}

#Preview {
    ColorGrad5View()
}
