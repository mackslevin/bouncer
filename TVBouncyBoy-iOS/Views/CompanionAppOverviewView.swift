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
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "rectangle.inset.bottomleft.filled").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("**Finally**, an app that allows you to see a rectangle bounce around on your very own TV screen!")
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "appletv.fill").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("As the primary experience is on Apple TV, be sure to visit the App Store there to download the Bouncer tvOS app if you haven't already.")
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "photo.tv").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("This companion app allows you to upload and manage your own images to use in the TV app.")
                    }
                    
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "hand.thumbsup.fill").resizable().scaledToFit()
                            .frame(height: 50)
                            .foregroundStyle(.accent)
                        
                        Text("Thanks for downloading! Enjoy!")
                    }
                }
                .fontDesign(.rounded)
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
