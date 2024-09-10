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
                    HStack {
                        Text("Voice Selection")
                    }
                    HStack {
                        Text("Text Display Selection")
                    }
                    HStack {
                        Text("Voice Setting")
                    }
                }
                
                Section {
                    HStack {
                        Text("How to Get Free Premium & Enhanced Neural Voices")
                    }
                    HStack {
                        Text("Give feedback to developer(me)")
                    }
                    HStack {
                        Text("Leave a review")
                    }
                }
                
                Section {
                    HStack {
                        Text("About")
                    }
                    HStack {
                        Text("Version")
                    }
                }
            }
        }
    }
}

#Preview {
    MainSettingsView()
}
