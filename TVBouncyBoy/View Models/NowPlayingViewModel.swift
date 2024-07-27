//
//  NowPlayingViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI
import MediaPlayer
import Observation

@Observable
final class NowPlayingViewModel {
    var nowPlayingTitle: String = ""
    var nowPlayingArtist: String = ""
    var nowPlayingAlbum: String = ""
    var nowPlayingArtwork: UIImage? = nil
    
    var timer: Timer?
    
    init() {
        updateNowPlayingInfo()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.updateNowPlayingInfo()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateNowPlayingInfo() {
        print("^^ Updating")
        
        if let nowPlayingItem = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem {
            nowPlayingAlbum = nowPlayingItem.albumTitle ?? "Unknown Album"
            nowPlayingArtist = nowPlayingItem.artist ?? "Unknown Artist"
            nowPlayingTitle = nowPlayingItem.title ?? "Unknown Title"
            nowPlayingArtwork = nowPlayingItem.artwork?.image(at: nowPlayingItem.artwork?.bounds.size ?? CGSize(width: 500, height: 500))
        } else {
            print("^^ No now playing item")
        }
    }
    
    func someNowPlayingInfoExists() -> Bool {
        !nowPlayingAlbum.isEmpty || !nowPlayingTitle.isEmpty || !nowPlayingArtist.isEmpty || nowPlayingArtwork != nil
    }
}
