//
//  MainSettingsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/09/24.
//

import SwiftUI

struct MainSettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        VoiceSelectorView()
                    } label: {
                        HStack {
                            Text("Voice Selection")
                        }
                    }
                    NavigationLink {
                        Form {
                            TextDisplayCustomizationView()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Text Display Customization")

                    } label: {
                        HStack {
                            Text("Text Display Customization")
                        }
                    }
                    NavigationLink {
                        Form {
                            VoiceSettingsView()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Voice Settings")

                    } label: {
                        HStack {
                            Text("Voice Setting")
                        }
                    }
                }

                Section {
                    NavigationLink {
                        GetNeuralVoicesView()
                    } label: {
                        HStack {
                            Text("How to get free Premium & Enhanced Neural Voices")
                        }
                    }

                    Link(destination: URL(string: "https://forms.gle/D1dEGQqCryQYaZqh8")!) {
                        HStack {
                            Text("Give feedback to developer(me)")
                        }
                    }

                    HStack {
                        LeaveReviewView(label: "Leave a review")
                    }
                }

                Section {
                    HStack {
                        Text("About")
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.appVersionShort)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    MainSettingsView()
}
