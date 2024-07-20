//
//  CheckCircle.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/19/24.
//

import SwiftUI

struct CheckCircle: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.thinMaterial)
            Image(systemName: "checkmark.circle")
                .resizable().scaledToFit()
        }
        .frame(width: 32)
        .padding(6)
    }
}

#Preview {
    CheckCircle()
}
