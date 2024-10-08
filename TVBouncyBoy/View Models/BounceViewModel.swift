//
//  ContentViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI
import Observation



@Observable
class BounceViewModel {
    var position: CGPoint = CGPoint(x: 100, y: 100)
    var velocity: CGSize = CGSize(width: 4, height: 4)
    var timer: Timer?
    var screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let rectangleSize: CGSize = CGSize(width: 390, height: 220)
    var tighteningAmount: CGFloat = 20
    var shouldTighten = false
    
    var isLoading = true // This is set to false when BounceView's box image overlay loads
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.updatePosition()
        }
    }

    func updatePosition() {
        var newX = position.x + velocity.width
        var newY = position.y + velocity.height
        
        if newX - rectangleSize.width / 2 < 0 || newX + rectangleSize.width / 2 > screenSize.width {
            velocity.width = -velocity.width
        }
        
        if newY - rectangleSize.height / 2 < 0 || newY + rectangleSize.height / 2 > screenSize.height {
            velocity.height = -velocity.height
        }
        
        newX = max(rectangleSize.width / 2, min(newX, screenSize.width - rectangleSize.width / 2))
        newY = max(rectangleSize.height / 2, min(newY, screenSize.height - rectangleSize.height / 2))
        
        withAnimation(.linear(duration: 0.05)) {
            position = CGPoint(x: newX, y: newY)
            
            self.isLoading = false
        }
    }
    
    func applyTightening() {
        guard shouldTighten else { return }
        screenSize.width -= tighteningAmount
        screenSize.height -= tighteningAmount
    }
}

