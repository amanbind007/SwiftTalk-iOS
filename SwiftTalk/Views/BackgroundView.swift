//
//  TempView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/08/24.
//

import SwiftUI

struct BackgroundView: View {
    @State var show = false
    var body: some View {
        Image(uiImage: UIImage.back2)
            .resizable()
            .overlay {
                EmptyView()
                    .background(Material.ultraThickMaterial)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
