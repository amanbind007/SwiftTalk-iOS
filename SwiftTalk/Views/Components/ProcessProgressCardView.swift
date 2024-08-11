//
//  ProcessProgressCardView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/08/24.
//

import Lottie
import SwiftUI

struct ProcessProgressCardView: View {
    @State var total: Float
    @State var value: Float
    @State var showProgressCard: Bool
    var body: some View {
        if showProgressCard {
            VStack {
                LottieView(animation: .named("GearsAnimation"))
                    .playing(loopMode: .loop)
                    .frame(height: 250)

                Text("Parsing Text")
                LinearProgressBar(value: value, total: total, color: Color.deepOrange)
                    .padding()
            }
            .background(Material.ultraThick)
            .cornerRadius(12)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .background(
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ProcessProgressCardView(total: 100, value: 55, showProgressCard: true)
}
