//
//  ListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftUI

struct ListItemView: View {
    
    var imageNames = ["red_text", "yellow_text", "green_text", "blue_text", "purple_text", "pink_text"]
    
    var body: some View {
        HStack{
            Image(imageNames.randomElement()!, bundle: Bundle(path: "Assests"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
            
            VStack(alignment: .leading){
                Text("Hello World")
                    .font(.custom("NotoSerif-Regular", size: 22))
                    
                    
                Text("\(Date().formatted(date: .abbreviated, time: .shortened))".uppercased())
                    .font(.custom("NotoSerif-Regular", size: 12))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
            
            }
            
        }
    }
}

#Preview {
    ListItemView()
}
