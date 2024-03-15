//
//  AddNewTextOptionCardView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import SwiftUI

struct AddNewTextOptionCardView: View {
    
    var title: String
    var description: String
    var imageName: String
    
    @Environment(\.colorScheme) var theme
    
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .underline()
                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                    .foregroundStyle(theme == .dark ? Color.white : Color.black)
                
                Text(description)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(theme == .dark ? Color.white : Color.black)
                    
            }
            Spacer()
        }
        .padding(10)
        .background(Color.accent1)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .padding([.horizontal], 8)
        
    }
}

#Preview {
    AddNewTextOptionCardView(title: "Word Document", description: "Add documents from your local storage or cloud", imageName: Constants.Icons.wordFileIcon)
}
