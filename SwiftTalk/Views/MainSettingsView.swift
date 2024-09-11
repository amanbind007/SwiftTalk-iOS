//
//  MainSettingsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/09/24.
//

import SwiftUI

struct MainSettingsView: View {
    var body: some View {
        VStack {
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
                        SettingsView()
                    } label: {
                        HStack {
                            Text("Text Display Customization")
                        }
                    }

                    NavigationLink {
                        SettingsView()
                    } label: {
                        HStack {
                            Text("Voice Setting")
                        }
                    }
                }

                Section {
                    HStack {
                        Text("How to Get Free Premium & Enhanced Neural Voices")
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

                GroupBox {}
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
        }
    }
}

#Preview {
    MainSettingsView()
}
