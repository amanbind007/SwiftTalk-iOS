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
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle("Get free Neural Voices")

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
                    NavigationLink {
                        Form {
                            ResetSettingsView()
                        }
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle("Voice Settings")

                    } label: {
                        HStack {
                            Text("Reset")
                        }
                    }
                }

                Section {
                    NavigationLink {

                        AboutView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle("About")

                    } label: {
                        HStack {
                            Text("About")
                        }
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
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainSettingsView()
}
