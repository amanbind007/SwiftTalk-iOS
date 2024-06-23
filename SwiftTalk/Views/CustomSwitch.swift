//
//  CustomSwitch.swift
//  SwiftTalk
//
//  Created by Aman Bind on 23/06/24.
//

import SwiftUI

struct CustomSwitch: View {
    
    var iconSystemName: String
    var colorOn: Color
    var colorOff: Color
    var text: String
    @Binding var isOn: Bool
    @State var labelWidth: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 44 + labelWidth, height: 36)
                    .foregroundStyle(isOn ? colorOn.opacity(0.2) : colorOff.opacity(0.2))

                HStack {
                    if isOn {
                        Text(text)
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                            .overlay {
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: TextWidthKey.self, value: proxy.size.width)
                                }
                            }
                            .offset(x: 3)
                        
                        Circle()
                            .frame(width: 30)
                            .foregroundColor(colorOn)
                            .overlay {
                                Image(systemName: iconSystemName)
                                    .foregroundStyle(.white)
                            }
                    }else{
                        Circle()
                            .frame(width: 30)
                            .foregroundColor(colorOff)
                            .overlay {
                                Image(systemName: iconSystemName)
                                    .foregroundStyle(.white)
                            }
                        
                        
                        Text(text)
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                            .overlay {
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: TextWidthKey.self, value: proxy.size.width)
                                }
                            }
                            .offset(x: -3)
                        
                    }
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


//struct TextWidthKey: PreferenceKey {
//    static var defaultValue: CGFloat { 0 }
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}

#Preview {
    @State var isOn: Bool = true
     return CustomSwitch(iconSystemName: "pen", colorOn: .green, colorOff: .red, text: "edit", isOn: $isOn)
}




