//
//  ColorBarsView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/2/24.
//

import SwiftUI

struct ColorBarsView: View {
    
    let topRowColors: [Color] = [
        Color.white,
        Color(red: 1, green: 1, blue: 0),
        Color(red: 0, green: 1, blue: 1),
        Color(red: 0, green: 1, blue: 0),
        Color(red: 1, green: 0, blue: 1),
        Color(red: 1, green: 0, blue: 0),
        Color(red: 0, green: 0, blue: 1)
    ]
    
    let middleRowColors: [Color] = [
        Color(red: 0, green: 0, blue: 1),
        Color(red: 0, green: 0, blue: 0),
        Color(red: 1, green: 0, blue: 1),
        Color(red: 0, green: 0, blue: 0),
        Color(red: 0, green: 1, blue: 1),
        Color(red: 0, green: 0, blue: 0),
        Color(red: 1, green: 1, blue: 1)
    ]
    
    var body: some View {
        VStack(spacing:0) {
            GeometryReader { geo in
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(topRowColors, id: \.self) { color in
                            Rectangle()
                                .foregroundStyle(color)
                        }
                    }
                    .frame(height: geo.size.height * (9/12))
                    
                    HStack(spacing: 0) {
                        ForEach(middleRowColors, id: \.self) { color in
                            Rectangle()
                                .foregroundStyle(color)
                        }
                    }
                    .frame(height: geo.size.height * (1/12))
                    
                    Rectangle().foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    ColorBarsView()
}
