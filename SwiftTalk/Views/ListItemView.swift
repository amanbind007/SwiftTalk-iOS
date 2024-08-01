//
//  ListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftData
import SwiftUI

enum ParentListType {
    case HomeViewList
    case MostReadList
    case RecentlyCompletedList
}

struct ListItemView: View {
    let textData: TextData
    let parentListType: ParentListType


    var formattedPlayTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: textData.timeSpend) ?? "00:00:00"
    }

        var body: some View
    {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                CircularProgressView(value: textData.progress, total: textData.text.count, color: textData.textSource.color, image: textData.textSource.imageName)
                    .frame(width: 65, height: 65)
                    .offset(x:-5)

                VStack(alignment: .leading, spacing: 0) {
                    Text(textData.textTitle!)
                        .font(NotoFont.Regular(14))
                        .bold()
                        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .leading)

                    Text(textData.text)
                        .font(NotoFont.Regular(12))
                        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .leading)
                        .lineLimit(2, reservesSpace: false)
                        .offset(y: -7)
                    
                    switch parentListType {
                    case .HomeViewList:
                        Text("Estimated reading time: \(textData.estimateReadTime)")
                            .font(NotoFont.Regular(10))
                            .offset(y: -4)
                    case .MostReadList:
                        Text("Total Time Spend: \(formattedPlayTime)")
                            .font(NotoFont.Regular(10))
                            .offset(y: -4)
                    case .RecentlyCompletedList:
                        Text("Completed reading on: \(textData.completionDate!.formatted(date: .abbreviated, time: .shortened))")
                            .font(NotoFont.Regular(10))
                            .offset(y: -4)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ListItemView(textData: TextDataPreviewProvider.textData1, parentListType: .HomeViewList)
        .modelContainer(for: TextData.self)
}
