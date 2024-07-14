//
//  ListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftData
import SwiftUI

struct ListItemView: View {
    let textData: TextData

    var imageNames = [
        "image_file_icon",
        "link_icon",
        "pdf_file_icon",
        "text_file_icon",
        "word_file_icon",
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                CircularProgressView(value: textData.progress, total: textData.text.count, color: textData.textSource.color, image: textData.textSource.imageName)
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    Text(textData.textTitle!)
                        .font(.custom("NotoSerif-Regular", size: 14))
                        .bold()
                        .frame(width: .infinity, height: 1, alignment: .leading)

                    Text(textData.text)
                        .font(.custom("NotoSerif-Regular", size: 12))
                        .frame(width: .infinity, height: 40, alignment: .leading)

                    Text("\(Date(timeIntervalSince1970: textData.dateTime).formatted(date: .abbreviated, time: .shortened))".uppercased())
                        .font(.custom("NotoSerif-Regular", size: 10))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    ListItemView(textData: TextDataPreviewProvider.textData1)
        .modelContainer(for: TextData.self)
}
