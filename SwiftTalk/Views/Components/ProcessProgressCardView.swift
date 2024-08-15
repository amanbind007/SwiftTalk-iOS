//
//  ProcessProgressCardView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/08/24.
//

import Lottie
import SwiftUI

struct ProcessProgressCardView: View {
//    @State var total: Double
//    @State var value: Double
    @Binding var addNewTextOptionVM: AddNewTextOptionsViewModel
    
    var body: some View {
        if addNewTextOptionVM.isProcessingImages {
            VStack {
                LottieView(animation: .named("GearsAnimation"))
                    .playing(loopMode: .loop)
                    .frame(height: 250)

                Text("Parsing Text")
                LinearProgressBar(value: addNewTextOptionVM.progressValue, total: 1.0, color: Color.appTint)
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
    ProcessProgressCardView(addNewTextOptionVM: .constant(AddNewTextOptionsViewModel()))
}
