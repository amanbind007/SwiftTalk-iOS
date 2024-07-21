//
//  ConfettiView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import Lottie
import SpriteKit
import SwiftUI

struct ConfettiView: View {
    @Binding var textData: TextData
    @Binding var showConfettiAnimation: Bool

    var body: some View {
        if showConfettiAnimation && !textData.confettiShown {
            ZStack {
                GeometryReader(content: { geometry in
                    SpriteView(scene: ConfettiScene(size: geometry.size), options: [.allowsTransparency])
                        .ignoresSafeArea()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                })
                VStack {
                    LottieView(animation: .named("Completed"))
                        .playing(loopMode: .loop)
                        .shadow(color: .white, radius: 30)
                        .offset(y: -70)

                    LottieView(animation: .named("CompleteAnimation"))
                        .playing(loopMode: .playOnce)

                        .shadow(color: .white, radius: 30)
                        .frame(width: 350, height: 350)
                        .offset(y: -100)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .background {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
            }
            .onTapGesture {
                showConfettiAnimation = false
                textData.confettiShown = true
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                    withAnimation {
                        showConfettiAnimation = false
                        textData.confettiShown = true
                    }
                }
            }
        }
    }
}

#Preview {
    ConfettiView(textData: .constant(TextDataPreviewProvider.textData1), showConfettiAnimation: .constant(true))
}
