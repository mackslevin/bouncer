//
//  OptionsViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/24/24.
//

import Foundation
import Observation

@Observable
final class OptionsViewModel {
    var isShowingSettings = false
    var isShowingTriviaInfo = false
    
    func customImages(appImages: [AppImage], type: AppImage.ImageType) -> [AppImage] {
        appImages.filter({
            $0.presetName == nil && $0.imageType == type
        }).sorted()
    }
    
    func presetImages(appImages: [AppImage], type: AppImage.ImageType) -> [AppImage] {
        appImages.filter({
            $0.presetName != nil && $0.imageType == type
        }).sorted()
    }
}
