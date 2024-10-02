//
//  TextDisplayCustomizationView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/10/24.
//

import SwiftUI

struct TextDisplayCustomizationView: View {
    @AppStorage("textSize") var textSize = 16.0
    @AppStorage("selectedFont") var selectedFont = Constants.Fonts.NotoRegular
    @AppStorage("backgroundColor") var backgroundColor: Color = .init(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
    @AppStorage("foregroundColor") var foregroundColor: Color = .init(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
    @AppStorage("autoScroll") var autoScroll = true
    
    var body: some View {
        Section {
            Toggle(isOn: $autoScroll, label: {
                Text("Auto Scroll to higlighted Text")
                    .font(NotoFont.Regular(16))
            })

        } header: {
            Text("Auto-Scroll")
        }

        Section(header: Text("Fonts")) {
            NavigationLink {
                FontSelectorView(selectedfont: $selectedFont)
            } label: {
                HStack {
                    Text("Font \(Int(self.textSize))")
                        .font(NotoFont.Regular(16))
                    Spacer()
                    Text("Selected Font")
                        .font(.custom(selectedFont, size: 16))
                }
            }
        }

        Section(header: Text("Colors")) {
            ColorPicker("Background Color", selection: self.$backgroundColor)
                .font(NotoFont.Regular(16))
            ColorPicker("Foreground Color", selection: self.$foregroundColor)
                .font(NotoFont.Regular(15))
        }

        Section(header: Text("Text Size")) {
            HStack {
                Text("Text Size: \(Int(self.textSize))")
                    .font(NotoFont.Regular(16))
                Stepper("", value: self.$textSize, in: 10...30, step: 1)
            }

            HStack {
                Text("This is Preview Text Example") { string in

                    if let range = string.range(of: "Preview Text") { 
                        string[range].foregroundColor = self.foregroundColor
                        string[range].backgroundColor = self.backgroundColor
                    }
                }
                .font(.custom(selectedFont, size: self.textSize))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(Color.green)
            }
        }
    }
}

#Preview {
    TextDisplayCustomizationView()
}
