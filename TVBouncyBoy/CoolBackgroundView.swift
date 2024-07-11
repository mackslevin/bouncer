//
//  CoolBackgroundView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI

struct CoolBackgroundView: View {
    var backgroundType: CoolBackground
    
    var body: some View {
        switch backgroundType {
            case .grad1:
                LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .grad2:
                LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .grad3:
                LinearGradient(colors: [.teal, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .img1:
                Image("lake").resizable().scaledToFill()
            case .img2:
                Image("blue-cloth").resizable().scaledToFill()
            case .img3:
                Image("color-puffs").resizable().scaledToFill()
        }
    }
}

//#Preview {
//    CoolBackgroundView()
//}
