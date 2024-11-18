//
//  BouncingForegroundView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI



struct BouncingForegroundView<Content: View>: View {
    @Bindable var homeVM: TVHomeViewModel
    @State private var bounceVM = BounceViewModel()
    
    let backgroundView: Content
    
    @State private var boxImageProxy: Image? = nil
    @AppStorage(StorageKeys.dimBackground.rawValue) var dimBackground = false
    @AppStorage(StorageKeys.hideBox.rawValue) var hideBox = false
    
    init(homeVM: TVHomeViewModel, @ViewBuilder content: () -> Content) {
        self.homeVM = homeVM
        self.backgroundView = content()
    }
    
    var body: some View {
        Button {
            homeVM.isShowingOptions.toggle()
        } label: {
            Canvas { context, size in
                if let bg = context.resolveSymbol(id: 0) {
                    context.draw(bg, in: CGRect(origin: .zero, size: size))
                }
                
                let rect = CGRect(x: bounceVM.position.x - bounceVM.rectangleSize.width / 2,
                                  y: bounceVM.position.y - bounceVM.rectangleSize.height / 2,
                                  width: bounceVM.rectangleSize.width,
                                  height: bounceVM.rectangleSize.height)
                
                if let boxy = context.resolveSymbol(id: 1) {
                    context.draw(boxy, in: rect)
                }
            } symbols: {
                Rectangle()
                    .foregroundStyle(.black)
                    .overlay {
                        ZStack {
                            if bounceVM.isLoading {
                                VStack {
                                    Image("logo")
                                        .resizable().scaledToFit()
                                        .frame(width: UIScreen.main.bounds.height/2)
                                    Text("Setting things up...")
                                        .fontDesign(.rounded)
                                }
                                .foregroundStyle(.secondary)
                            } else {
                                backgroundView
                                
                                Color.black
                                    .opacity(dimBackground ? 0.5 : 0)
                            }
                        }
                    }
                    .clipped()
                    .tag(0)
                
                if !hideBox {
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .frame(width: bounceVM.rectangleSize.width, height: bounceVM.rectangleSize.height)
                        .overlay {
                            Group {
                                switch homeVM.foregroundMode {
                                    case .standardBounce:
                                        if let boxImg = boxImageProxy {
                                            boxImg.resizable().scaledToFill()
                                        }
                                        
                                    // MARK: Foreground modes
                                    case .clock1:
                                        Clock1View()
                                    case .clock2:
                                        Clock2View()
                                    case .clock3:
                                        Clock3View()
                                    case .clock4:
                                        Clock4View()
                                    case .clock5:
                                        Clock5View()
                                    case .clock6:
                                        Clock6View()
                                    case .emoji1:
                                        Emoji1View(bounceVM: bounceVM)
                                    case .emoji2:
                                        Emoji2View(bounceVM: bounceVM)
                                    case .trivia1:
                                        Trivia1View()
                                    case .oscars1:
                                        Oscars1View()
                                    case .nowPlayingForeground1:
                                        NowPlayingForeground1()
                                }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: Utility.boxCornerRadius))
                        .tag(1)
                        .opacity(bounceVM.isLoading ? 0 : 1)
                }
                
            }
            .onAppear {
                bounceVM.startTimer()
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                bounceVM.timer?.invalidate()
            }
        }
        .buttonStyle(BlankButtonStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
        .onAppear {
            boxImageProxy = homeVM.boxImage?.imageValue
            bounceVM.applyTightening()
        }
        .onChange(of: homeVM.boxImage, { _, newValue in
            boxImageProxy = newValue?.imageValue
        })
    }
}

#Preview {
    BouncingForegroundView(homeVM: TVHomeViewModel()) {
        Rectangle().foregroundStyle(Color.green)
    }
}
