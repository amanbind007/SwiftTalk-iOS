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
        YouTubePlayerView(
            YouTubePlayer(
                source: YouTubePlayer.Source.url(videoLink),
                configuration: .init(useModestBranding:false)
                
            ),
            placeholderOverlay: {
                ProgressView()
            }
            
        )
        .padding()
    }
}

#Preview {
    GetNeuralVoicesView()
}
