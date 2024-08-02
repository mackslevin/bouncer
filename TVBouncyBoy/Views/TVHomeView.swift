//
//  TVHomeView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI
import MediaPlayer

struct TVHomeView: View {
    @State private var vm = TVHomeViewModel()
    
    var body: some View {
        Group {
            switch vm.backgroundMode {
                case .standardBounce:
                    BouncingForegroundView(homeVM: vm) {
                        if let img = vm.backgroundImage?.imageValue {
                            img.resizable().scaledToFill()
                        }
                    }
                
                case .nowPlaying1:
                    BouncingForegroundView(homeVM: vm) {
                        NowPlaying1View()
                    }
//                    .onPlayPauseCommand {
//                        Utility.nowPlayingHandlePlayPauseButton()
//                    }
                
                case .nowPlaying2:
                    BouncingForegroundView(homeVM: vm) {
                        NowPlaying2View()
                    }
//                    .onPlayPauseCommand {
//                        Utility.nowPlayingHandlePlayPauseButton()
//                    }
                
                case .nowPlaying3:
                    BouncingForegroundView(homeVM: vm) {
                        NowPlaying3View()
                    }
//                    .onPlayPauseCommand {
//                        Utility.nowPlayingHandlePlayPauseButton()
//                    }
                    
                case .colorBars:
                    BouncingForegroundView(homeVM: vm) {
                        ColorBarsView()
                    }       
            }
        }
        .onPlayPauseCommand {
            Utility.nowPlayingHandlePlayPauseButton()
        }
        .sheet(isPresented: $vm.isShowingOptions, content: {
            OptionsView(homeVM: vm)
        })
        .sheet(isPresented: $vm.isShowingOverview, content: {
            OverviewView()
        })
        
    }
}

#Preview {
    TVHomeView()
}
