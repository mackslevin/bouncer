//
//  ContentView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hi world")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
