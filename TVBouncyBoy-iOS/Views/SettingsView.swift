//
//  SettingsView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/23/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(StorageKeys.warnBeforeDelete.rawValue) var warnBeforeDelete: Bool = true
    @AppStorage(StorageKeys.boxShouldHaveRoundedCorners.rawValue) var roundedCorners = true
    @AppStorage(StorageKeys.dimBackground.rawValue) var dimBackground = false
    @AppStorage(StorageKeys.boxShouldHaveShadow.rawValue) var boxShadow = false
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $roundedCorners, label: {
                    VStack(alignment: .leading) {
                        Text("Rounded Corners")
                            .bold()
                        Text("When this setting is on, the bouncing box's corners will be slightly rounded.")
                            .foregroundStyle(.secondary)
                    }
                })
                Toggle("Dim Background", isOn: $dimBackground)
                Toggle(isOn: $boxShadow, label: {
                    VStack(alignment: .leading) {
                        Text("Box Shadow")
                            .bold()
                        Text("Do you want the little bouncing box to have a shadow? 🤷‍♂️")
                            .foregroundStyle(.secondary)
                    }
                })
                
                if !Utility.isTV() {
                    Toggle("Warn before deleting images?", isOn: $warnBeforeDelete)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
