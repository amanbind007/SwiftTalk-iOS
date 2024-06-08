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
            var predicate = #Predicate<TextData> { object in
                object.id == id
            }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            var object = try persistantContainer.mainContext.fetch(descriptor)
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
        let textDate = TextData(textTitle: title, text: text, textSource: textSource, iconType: textSource.imageName, dateTime: Date().timeIntervalSince1970)

        do {
            persistantContainer.mainContext.insert(textDate)
            try persistantContainer.mainContext.save()
        } catch {
            print("Save Error : \(error)")
        }
    }

    func updateObject(id: UUID, text: String, title: String?) {
        if let textData = getObject(id: id) {
            textData.text = text
            textData.textTitle = title

            persistantContainer.mainContext.insert(textData)
            do {
                try persistantContainer.mainContext.save()
            } catch {
                print("Update Error : \(error)")
            }
        }
    }

    func deleteObject(textData: TextData) {
        persistantContainer.mainContext.delete(textData)

        do {
            try persistantContainer.mainContext.save()
        } catch {
            print("Delete Error: \(error)")
        }
    }
}
