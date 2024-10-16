//
//  ImageSorterView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 15/10/24.
//

import SwiftUI

struct ImageSorterView: View {
    @State var docImages: [UIImage] = [.doc1, .doc2, .doc3, .doc4, .doc5, .doc6, .doc7, .doc8]
    @State var draggingImage: UIImage?
    var body: some View {
        VStack {
            Text("Re-arrange the Order")
                .bold()
                .font(.title)

            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(spacing: 10), count: 2)
                LazyVGrid(columns: columns, spacing: 10) {

                    ForEach(docImages, id: \.self) { image in

                        GeometryReader {
                            let size = $0.size

                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .background(Color(uiColor: .secondarySystemFill))
                                .foregroundStyle(Color(uiColor: .label))
                                .overlay {
                                ZStack {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                        .draggable(image) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .opacity(0.7)
                                            .frame(width: size.width, height: size.height)
                                            .onAppear {
                                            draggingImage = image
                                        }

                                    }

                                    VStack {
                                        HStack {
                                            if let index = docImages.firstIndex(of: image) {
                                                Text("\(index + 98)")
                                                    .bold()
                                                    .foregroundStyle(Color.white)
                                                    .padding(.horizontal, 7)
                                                    .background {
                                                    Capsule()
                                                        .foregroundStyle(Color.accentColor)

                                                }
                                            }

                                            Spacer()
                                        }
                                            .padding(7)
                                        Spacer()
                                    }


                                }

                            }
                                .dropDestination(for: Image.self) { items, location in
                                return false
                            } isTargeted: { status in
                                if let draggingImage, status, draggingImage != image {
                                    if let sourceIndex = docImages.firstIndex(of: draggingImage), let destinationIndex = docImages.firstIndex(of: image) {

                                        withAnimation(.bouncy) {
                                            let sourceItem = docImages.remove(at: sourceIndex)
                                            docImages.insert(sourceItem, at: destinationIndex)
                                        }
                                    }
                                }
                            }
                        }
                            .frame(height: 250)

                    }
                }
                    .padding()
            }
        }
    }
}

extension UIImage: @retroactive Transferable {

    public static var transferRepresentation: some TransferRepresentation {

        DataRepresentation(exportedContentType: .png) { image in
            if let pngData = image.pngData() {
                return pngData
            } else {
                // Handle the case where UIImage could not be converted to png.
                throw ConversionError.failedToConvertToPNG
            }
        }
    }

    enum ConversionError: Error {
        case failedToConvertToPNG
    }
}

#Preview {
    ImageSorterView()
}
