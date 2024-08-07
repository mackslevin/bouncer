//
//  Emoji1View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/2/24.
//

import SwiftUI

struct Emoji1View: View {
    @Bindable var bounceVM: BounceViewModel
    @State private var emoji = "😀"
    @State private var bgColor: Color = .white
    @State private var lastCollision: Date = .now
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(bgColor.gradient)
            Text(emoji)
                .font(.system(size: 3000))
                .minimumScaleFactor(0.01)
                .padding()
        }
        .onChange(of: bounceVM.position) { _, newValue in
            if
                (newValue.x - bounceVM.rectangleSize.width/2 == 0 ||
                newValue.x + bounceVM.rectangleSize.width/2 == bounceVM.screenSize.width ||
                newValue.y - bounceVM.rectangleSize.height/2 == 0 ||
                newValue.y + bounceVM.rectangleSize.height/2 == bounceVM.screenSize.height) &&
                Date().timeIntervalSince(lastCollision) > 0.1 // To get around issue where emoji would rapidly change twice during a single collision
                
            {
                handleBounce()
                lastCollision = .now
            }
        }
        
    }
    
    func handleBounce() {
        var randomEmoji = someEmojis.randomElement()
        while randomEmoji == emoji {
            randomEmoji = someEmojis.randomElement()
        }
        guard let randomEmoji else { return }
        
        withAnimation(.linear(duration: 0.05)) {
            emoji = randomEmoji
        }
    }
    
    let someEmojis = [
        "😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃", "😉", "😊", "😇", "🥰", "😍", "🤩", "😘", "😗", "☺️", "😚", "😙", "😋", "😛", "😜", "🤪", "😝", "🤑", "🤗", "🤭", "🤫", "🤔", "🤐", "🤨", "😐", "😑", "😶", "😏", "😒", "🙄", "😬", "🤥", "😌", "😔", "😪", "🤤", "😴", "😷", "🤒", "🤕", "🤢", "🤮", "🤧", "🥵", "🥶", "🥴", "😵", "🤯", "🤠", "🥳", "😎", "🤓", "🧐", "😕", "😟", "🙁", "☹️", "😮", "😯", "😲", "😳", "🥺", "😦", "😧", "😨", "😰", "😥", "😢", "😭", "😱", "😖", "😣", "😞", "😓", "😩", "😫", "🥱", "😤", "😡", "😠", "🤬", "😈", "👿", "💀", "☠️", "💩", "🤡", "👹", "👺", "👻", "👽", "👾", "🤖", "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾"
    ]
}

#Preview {
    Emoji1View(bounceVM: BounceViewModel())
}
