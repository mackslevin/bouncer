//
//  OverviewView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/25/24.
//

import SwiftUI

struct CompanionAppOverviewView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 0) {
                        Text("Welcome to")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(.accent)
                        Image("logo-accent").resizable().scaledToFit()
                            .padding(.horizontal, 50)
                        
                        Text("**Finally**, an app that allows you to see a rectangle bouncing around within another rectangle!")
                            .padding(.top, 24)
                    }
                    
                    
                    
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "appletv.fill").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("The primary experience is on Apple TV, so be sure to visit the App Store there to download the Bouncer tvOS app. ")
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "macbook.and.iphone").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                            Text("This companion app allows you to upload and preview your own images for use on the TV app. ")
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "hand.thumbsup.fill").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("Thanks for downloading! Enjoy!")
                    }
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", systemImage: "xmark.circle") {
                            dismiss()
                        }
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    CompanionAppOverviewView()
        .fontDesign(.rounded)
}
