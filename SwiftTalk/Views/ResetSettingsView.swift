//
//  ResetSettingsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/10/24.
//

import SwiftUI

struct ResetSettingsView: View {

    var body: some View {
        List {
            Section {
                Button(role: .destructive) {
                    //
                } label: {
                    HStack {
                        Text("Reset Settings")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "gearshape.arrow.trianglehead.2.clockwise.rotate.90")
                    }
                }
            } footer: {
                Text("Resets all the reading texts and progress stats in the app")
                    .font(.caption)
            }

            Section {
                Button(role: .destructive) {
                    //
                } label: {

                    HStack {
                        Text("Reset Data")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "swiftdata")
                    }

                }
            } footer: {
                Text("Reset all the settings like text view customization, voice speech, rate, text color, backgroung color, etc.")
                    .font(.caption)
            }

            Section {
                Button(role: .destructive) {
                    //
                } label: {
                    HStack {
                        Text("Reset Data & Settings")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "gearshape.arrow.trianglehead.2.clockwise.rotate.90")
                        Text("+")
                        Image(systemName: "swiftdata")
                    }
                }
            } footer: {
                Text("Resets all the everything in the app, both data and settings")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    ResetSettingsView()
}
