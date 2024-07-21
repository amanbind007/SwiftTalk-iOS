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

    var formattedPlayTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: textData.timeSpend) ?? "00:00:00"
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                CircularProgressView(value: textData.progress, total: textData.text.count, color: textData.textSource.color, image: textData.textSource.imageName)
                    .frame(width: 65, height: 65)

                VStack(alignment: .leading, spacing: 0) {
                    Text(textData.textTitle!)
                        .font(.custom("NotoSerif-Regular", size: 14))
                        .bold()
                        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .leading)

                    Text(textData.text)
                        .font(.custom("NotoSerif-Regular", size: 12))
                        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .leading)
                        .lineLimit(2, reservesSpace: false)
                        .offset(y: -7)

                    Text("Estimated reading time: \(textData.estimateReadTime)")
                        .font(.custom("NotoSerif-Regular", size: 10))
                        .offset(y: -4)
                }
            }
        }
    }
}

#Preview {
    ListItemView(textData: TextDataPreviewProvider.textData1)
        .modelContainer(for: TextData.self)
}
