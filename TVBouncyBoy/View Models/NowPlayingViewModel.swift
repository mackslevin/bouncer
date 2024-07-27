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
    
    private let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    init() {
        updateNowPlayingInfo()
        registerForNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateNowPlayingInfo() {
        if let nowPlayingItem = musicPlayer.nowPlayingItem {
            withAnimation {
                nowPlayingAlbum = nowPlayingItem.albumTitle ?? "Unknown Album"
                nowPlayingArtist = nowPlayingItem.artist ?? "Unknown Artist"
                nowPlayingTitle = nowPlayingItem.title ?? "Unknown Title"
                nowPlayingArtwork = nowPlayingItem.artwork?.image(at: nowPlayingItem.artwork?.bounds.size ?? CGSize(width: 1000, height: 1000))
            }
        } else {
            print("^^ No now playing item")
        }
    }
    
    func registerForNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(updateNowPlayingInfo), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer)
            NotificationCenter.default.addObserver(self, selector: #selector(updateNowPlayingInfo), name: .MPMusicPlayerControllerPlaybackStateDidChange, object: musicPlayer)
            
            musicPlayer.beginGeneratingPlaybackNotifications()
        }
    
    func someNowPlayingInfoExists() -> Bool {
        !nowPlayingAlbum.isEmpty || !nowPlayingTitle.isEmpty || !nowPlayingArtist.isEmpty || nowPlayingArtwork != nil
    }
}
