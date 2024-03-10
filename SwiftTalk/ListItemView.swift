//
//  ListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftUI

struct ListItemView: View {
    var body: some View {
        HStack{
            Image(systemName: "photo.artframe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            VStack(alignment: .leading){
                Text("Hello World")
                    .font(.title3)
                    
                Text("\(Date().formatted(date: .abbreviated, time: .shortened))".uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
                    
            }
            
        }
    }
}

#Preview {
    ListItemView()
}
