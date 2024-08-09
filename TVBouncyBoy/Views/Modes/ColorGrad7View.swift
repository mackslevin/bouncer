//
//  ColorGrad7View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/8/24.
//

import SwiftUI

struct ColorGrad7View: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                EllipticalGradient(colors:[
                    Color(red: 0, green: 0, blue: 128/255),
                    Color(red: 0, green: 0, blue: 28/255)
                ])
            )
    }
}

#Preview {
    ColorGrad7View()
}
