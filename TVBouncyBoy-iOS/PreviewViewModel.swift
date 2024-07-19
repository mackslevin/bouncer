//
//  PreviewViewModel.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import Observation

@Observable
final class PreviewViewModel {
    let rectangleSize: CGSize = CGSize(width: 60, height: 32)
    var containerSize: CGSize = CGSize(width: 300, height: 300)
    var timer: Timer?
    var velocity: CGSize = CGSize(width: 1, height: 1)
    var position: CGPoint = CGPoint(x: 30, y: 16)
    
    // When the selected AppImage values change, the poxy versions are set in the view via onChange modifiers
    var selectedBackgroundImage: AppImage?
    var selectedBoxImage: AppImage?
    var proxyBackgroundImage: Image?
    var proxyBoxImage: Image?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.updatePosition()
        }
    }

    func updatePosition() {
        var newX = position.x + velocity.width
        var newY = position.y + velocity.height
        
        if newX - rectangleSize.width / 2 < 0 || newX + rectangleSize.width / 2 > containerSize.width {
            velocity.width = -velocity.width
        }
        
        if newY - rectangleSize.height / 2 < 0 || newY + rectangleSize.height / 2 > containerSize.height {
            velocity.height = -velocity.height
        }
        
        newX = max(rectangleSize.width / 2, min(newX, containerSize.width - rectangleSize.width / 2))
        newY = max(rectangleSize.height / 2, min(newY, containerSize.height - rectangleSize.height / 2))
        
        withAnimation(.linear(duration: 0.05)) {
            position = CGPoint(x: newX, y: newY)
        }
    }
    
}
