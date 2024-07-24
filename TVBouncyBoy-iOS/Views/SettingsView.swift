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
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Toggle("Rounded Corners", isOn: $roundedCorners)
                    Text("When this setting is on, the bouncing box's corners will be slightly rounded.")
                        .foregroundStyle(.secondary)
                }
                
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
