//
//  BackgroudView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/08/24.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var theme
    @State var show = false
    var body: some View {
        Image(uiImage: UIImage.back5)
            .resizable()
            .overlay {
                EmptyView()
                    .background(theme == .dark ? Material.thickMaterial : Material.thin)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
