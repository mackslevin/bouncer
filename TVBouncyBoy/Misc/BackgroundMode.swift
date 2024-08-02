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
}
