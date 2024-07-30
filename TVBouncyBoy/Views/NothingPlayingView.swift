//
//  NothingPlayingView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/27/24.
//

import SwiftUI

struct NothingPlayingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Nothing Playing")
                .font(.displayFont(size: 34))
                
            VStack {
                Text("Play some music in the Music app.")
                Text("(If you want 🤷‍♂️)")
            }
            .foregroundStyle(.secondary)
            .fontDesign(.rounded)
            
        }
    }
}

#Preview {
    NothingPlayingView()
}
