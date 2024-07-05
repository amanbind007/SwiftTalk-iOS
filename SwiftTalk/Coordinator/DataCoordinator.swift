//
//  DataCoordinator.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/06/24.
//

import Foundation
import SwiftData

@MainActor
class DataCoordinator {
    static let shared = DataCoordinator()

    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: TextData.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()

    init() {}

    func getObject(id: UUID) -> TextData? {
        do {
            let predicate = #Predicate<TextData> { object in
                object.id == id
            }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            let object = try persistantContainer.mainContext.fetch(descriptor)
            return object.first
        } catch {
            print("Fetch Object : \(error)")
            return nil
        }
    }

    func doesObjectExist(id: UUID) -> Bool {
        return getObject(id: id) != nil
    }

    func doesObjectExistAndUpdated(id: UUID, title: String?, text: String) -> Bool {
        if let textData = getObject(id: id) {
            if textData.text != text || textData.textTitle != title {
                return true
            }
        }
        return false
    }

    func saveObject(text: String, title: String?, textSource: AddNewTextOption) {
        var autoTitle = ""

        if let title = title {
            autoTitle = title
        }

        else {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
            let formattedDate = dateFormatter.string(from: currentDate)
            autoTitle = "Text " + formattedDate
        }

        let textDate = TextData(textTitle: autoTitle, text: text, textSource: textSource, dateTime: Date().timeIntervalSince1970)

        do {
            persistantContainer.mainContext.insert(textDate)
            persistantContainer.mainContext.insert(textDate)
            try persistantContainer.mainContext.save()
        } catch {
            print("Save Error : \(error)")
        }
    }

    func deleteObject(textData: TextData) {
        do {
            persistantContainer.mainContext.delete(textData)
            try persistantContainer.mainContext.save()

        } catch {
            print("Delete Error: \(error)")
        }
    }
}
