//
//  OverviewView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/25/24.
//

import SwiftUI

struct OverviewView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                    Text("Welcome to")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundStyle(.accent)
                    Image("logo-accent").resizable().scaledToFit()
                        .frame(maxWidth: 500)
                        .padding(.bottom, 80)
                    
                    VStack(alignment: .leading, spacing: 80) {
                        
                        
                        HStack(alignment: .center, spacing: 26) {
                            Image(systemName: "rectangle.inset.bottomleft.filled").resizable().scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(.accent)
                            Text("**Finally**, an app that allows you to see a rectangle bounce around on your very own TV screen!")
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(alignment: .center, spacing: 26) {
                            Image(systemName: "photo.fill.on.rectangle.fill").resizable().scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(.accent)
                            Text("Choose images from our preset options. **Watch them bounce**.")
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(alignment: .center, spacing: 26) {
                            Image(systemName: "macbook.and.iphone").resizable().scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(.accent)
                            Text("Download the **companion app** from the App Store on another device and upload your own photos!")
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack {
                            Spacer()
                            Button("Cool, got it", systemImage: "checkmark.circle") {
                                dismiss()
                            }
                            Spacer()
                        }
                        
                        
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: 800)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OverviewView()
        .fontDesign(.rounded)
}
