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
                    .font(NotoFont.Bold(14))
                    .foregroundStyle(theme == .dark ? Color.white : Color.black)
                
                Text(description)
                    .font(NotoFont.Regular(13))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(theme == .dark ? Color.white : Color.black)
                    
            }
            Spacer()
        }
        
    }
}

#Preview {
    AddNewTextOptionCardView(title: "Word Document", description: "Add documents from your local storage or cloud", imageName: Constants.Icons.wordFileIcon)
}
