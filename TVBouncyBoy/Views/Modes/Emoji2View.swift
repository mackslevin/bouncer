//
//  Emoji2View.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 8/5/24.
//

import SwiftUI

struct Emoji2View: View {
    @Bindable var bounceVM: BounceViewModel
    @State private var emoji = "🐶"
    @State private var color = Color.indigo
    @State private var bgColor: Color = .white
    @State private var lastCollision: Date = .now
    
    let colors: [Color] = [
        .indigo,
        .pink,
        .yellow,
        .red,
        .purple,
        .green,
        .cyan,
        .brown,
        .mint,
        .orange,
        .teal
    ]
    
    var body: some View {
        VStack {
            ZStack {
                color
                
                VStack {
                    LazyHGrid(rows: [GridItem(), GridItem(), GridItem()], content: {
                        
                        
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                        Text(emoji)
                    })
                    .minimumScaleFactor(0.5)
                    .padding()
                }
                
                Text(emoji)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.1)
                    .padding()
            }
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
        var randomEmoji = animalEmojis.randomElement()
        while randomEmoji == emoji {
            randomEmoji = animalEmojis.randomElement()
        }
        
        var randomColor = colors.randomElement()
        while color == randomColor {
            randomColor = colors.randomElement()
        }
        
        guard let randomEmoji, let randomColor else { return }
        
        withAnimation(.linear(duration: 0.05)) {
            emoji = randomEmoji
            color = randomColor
        }
    }
    
    let animalEmojis = [
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵",
        "🙈", "🙉", "🙊", "🐒", "🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗",
        "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐜", "🪲", "🪳", "🕷", "🕸", "🦂", "🐢", "🐍", "🦎",
        "🦖", "🦕", "🐙", "🦑", "🦐", "🦞", "🦀", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋", "🦈", "🐊", "🐅",
        "🐆", "🦓", "🦍", "🦧", "🦣", "🐘", "🦛", "🦏", "🐪", "🐫", "🦒", "🦘", "🦬", "🐃", "🐂", "🐄",
        "🐎", "🐖", "🐏", "🐑", "🦙", "🐐", "🦌", "🐕", "🐩", "🦮", "🐕‍🦺", "🐈", "🐈‍⬛", "🐓", "🦃", "🦤",
        "🦚", "🦜", "🦢", "🦩", "🕊", "🐇", "🦝", "🦨", "🦡", "🦫", "🦦", "🦥", "🐁", "🐀", "🐿", "🦔"
    ]

}

#Preview {
    Emoji2View(bounceVM: BounceViewModel())
}
