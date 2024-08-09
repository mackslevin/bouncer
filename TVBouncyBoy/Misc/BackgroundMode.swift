//
//  ViewingMode.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import Foundation


enum BackgroundMode: String, Codable, CaseIterable {
    // The `standardBounce` mode is the one where the background is a static image, either from the user or a preset. Static background images are ignored for the other modes.

    case standardBounce = "standardBounce"
    case nowPlaying1 = "nowPlaying1"
    case nowPlaying2 = "nowPlaying2"
    case nowPlaying3 = "nowPlaying3"
    
    case colorBars = "colorBars"
    
    case colorGrad1 = "colorGrad1"
    case colorGrad2 = "colorGrad2"
    case colorGrad3 = "colorGrad3"
    case colorGrad4 = "colorGrad4"
    case colorGrad5 = "colorGrad5"
    case colorGrad6 = "colorGrad6"
    case colorGrad7 = "colorGrad7"
}
