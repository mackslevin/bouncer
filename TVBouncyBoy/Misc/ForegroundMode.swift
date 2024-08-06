//
//  ForegroundMode.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/29/24.
//

import Foundation



enum ForegroundMode: String, Codable, CaseIterable {
    // The `standardBounce` mode is the one where the bouncy box is a static image, either from the user or a preset. Static box images are ignored for the other modes.

    case standardBounce = "standardBounce"
    case clock1 = "clock1"
    case clock2 = "clock2"
    case clock3 = "clock3"
    case clock4 = "clock4"
    case clock5 = "clock5"
    case emoji1 = "emoji1"
    case emoji2 = "emoji2"
}
