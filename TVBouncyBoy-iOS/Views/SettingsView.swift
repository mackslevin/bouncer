//
//  SettingsView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/23/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(StorageKeys.warnBeforeDelete.rawValue) var warnBeforeDelete: Bool = true
    @AppStorage(StorageKeys.boxShouldHaveRoundedCorners.rawValue) var roundedCorners = false
    @AppStorage(StorageKeys.dimBackground.rawValue) var dimBackground = false
    @AppStorage(StorageKeys.hideBox.rawValue) var hideBox = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingOverview = false
    @State private var isShowingPhotoCredits = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Spacer()
                    Image("logo-accent")
                        .resizable().scaledToFit()
                        .padding()
                        
                        .frame(maxWidth: 500)
                    Spacer()
                    
                }
                .listRowBackground(EmptyView())
                .padding(.bottom, Utility.isTV() ? 10 : -20)
                .padding(.top, Utility.isTV() ? 0 : -20)
                    
                if Utility.isTV() {
                    Section {
                        Toggle(isOn: $roundedCorners, label: {
                            VStack(alignment: .leading) {
                                Text("Rounded Corners")
                                    
                                Text("When this setting is on, the bouncing box's corners will be slightly rounded.")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.medium)
                            }
                        })
                        .bold()
                        
                        
                        
                        Toggle("Dim Background", isOn: $dimBackground)
                            .bold()
                        

                        
                        Toggle(isOn: $hideBox, label: {
                            VStack(alignment: .leading) {
                                Text("Hide the Bouncing Box")
                                    
                                Text("We won't tell Boxy. It'd break his heart.")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.medium)
                            }
                        })
                        .bold()
                        
                    }
                    
                    
                    Section {
                        Button("Show Overview", systemImage: "info.circle") {
                            isShowingOverview.toggle()
                        }
                        .tint(.accent)
                    }
                    
                    
                } else {
                    Section {
                        Toggle("Warn before deleting images?", isOn: $warnBeforeDelete)
                    }
                }
                
                Section {
                    Button("Photo Credits", systemImage: "photo") {
                        isShowingPhotoCredits.toggle()
                    }
                    .tint(.accent)
                }
                
                
            }
            .tint(Utility.isTV() ? .primary : .accent)
            .navigationTitle("Settings")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") { dismiss() }.bold()
                }
            }
            .sheet(isPresented: $isShowingOverview, content: {
                #if os(tvOS)
                    OverviewView()
                #endif
            })
            .fontDesign(.rounded)
            .sheet(isPresented: $isShowingPhotoCredits, content: {
                
                PhotoCreditsView()
                
            })
        }
    }
}

#Preview {
    SettingsView()
}
