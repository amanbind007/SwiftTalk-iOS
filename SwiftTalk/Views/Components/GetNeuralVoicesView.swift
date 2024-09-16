//
//  GetNeuralVoicesView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/09/24.
//

import SwiftUI
import YouTubePlayerKit

struct GetNeuralVoicesView: View {
    let videoLink = "https://www.youtube.com/shorts/LyV7FNh3sDM"
    var body: some View {
        List {
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "settingsIconIos")!)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Go to settings")
                }
            }
            
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "accessibilityIconIos")!)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Go to Accessibility")
                }
            }
            
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "accessibilityIconIos")!)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Go to Live Speech")
                }
            }
            
        }
            
//            YouTubePlayerView(
//                YouTubePlayer(
//                    source: YouTubePlayer.Source.url(videoLink),
//                    configuration: .init(useModestBranding:false)
//
//                ),
//                placeholderOverlay: {
//                    ProgressView()
//                }
//
//            )
//            .padding()
    }
}

#Preview {
    GetNeuralVoicesView()
}
