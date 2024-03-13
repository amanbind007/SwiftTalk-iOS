//
//  ListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftUI

struct ListItemView: View {
    var imageNames = [
                      "image_file_icon",
                      "link_icon",
                      "pdf_file_icon",
                      "text_file_icon",
                      "word_file_icon"]

    var body: some View {
        HStack {
            Image(imageNames.randomElement()!, bundle: Bundle(path: "Assests"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)

            VStack(alignment: .leading) {
                Text("Hello World")
                    .font(.custom("NotoSerif-Regular", size: 16))

                Text("\(Date().formatted(date: .abbreviated, time: .shortened))".uppercased())
                    .font(.custom("NotoSerif-Regular", size: 10))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ListItemView()
}
