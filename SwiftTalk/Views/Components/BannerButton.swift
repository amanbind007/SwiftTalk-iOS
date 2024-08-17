//
//  CustomButton.swift
//  SwiftTalk
//
//  Created by Aman Bind on 23/06/24.
//

import SwiftUI

struct BannerButton: View {
    
    @Environment(\.colorScheme) var theme
    var iconSystemName: String
    var color: Color
    var text: String

    @State var labelWidth: CGFloat = 0

    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 44 + labelWidth, height: 36)
                    .foregroundStyle(color.opacity(0.2))

                HStack {
                    Circle()
                        .frame(width: 30, alignment: .leading)
                        .foregroundColor(color)
                        .overlay {
                            Image(systemName: iconSystemName)
                                .foregroundStyle(.white)
                        }

                    Text(text)
                        .foregroundStyle(theme == .dark ? .white : .black)
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(key: TextWidthKey.self, value: proxy.size.width)
                            }
                        }
                        .offset(x: -3)
                }
                .padding(.horizontal, 3)
            }
            .onPreferenceChange(TextWidthKey.self) { value in
                DispatchQueue.main.async {
                    labelWidth = value
                }
            }
        }
    }
}

struct TextWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    HStack {
        BannerButton(iconSystemName: "trash", color: .red, text: "Delete")
        BannerButton(iconSystemName: "square.and.arrow.down", color: .green, text: "Save")
        BannerButton(iconSystemName: "list.bullet.clipboard", color: .blue, text: "Paste")
    }
}
