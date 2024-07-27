//
//  TVHomeView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI

struct TVHomeView: View {
    @State private var vm = TVHomeViewModel()
    
    var body: some View {
        Group {
            switch vm.mode {
                case .standardBounce:
                    BounceView(homeVM: vm)
                case .nowPlaying1:
                    
                    BouncingForegroundView(homeVM: vm) {
                        NowPlaying1View()
                    }
            }
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
