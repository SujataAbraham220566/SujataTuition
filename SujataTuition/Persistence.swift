//
//  Persistence.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import CoreData
import CloudKit

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init() {
        container = NSPersistentCloudKitContainer(name: "DataModel")

        // Private
        let privateStoreDescription = container.persistentStoreDescriptions.first!
        privateStoreDescription.configuration = "Private"
        let storesURL = privateStoreDescription.url!.deletingLastPathComponent()
        privateStoreDescription.url = storesURL.appendingPathComponent("private.sqlite")
        privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        // Public
        guard let publicStoreDescription = privateStoreDescription.copy() as? NSPersistentStoreDescription else {
            fatalError("Copying the private store description returned an unexpected value.")
        }
        publicStoreDescription.url = storesURL.appendingPathComponent("public.sqlite")
        publicStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: privateStoreDescription.cloudKitContainerOptions!.containerIdentifier)
        publicStoreDescription.cloudKitContainerOptions?.databaseScope = .public
        publicStoreDescription.configuration = "Public"
        container.persistentStoreDescriptions.append(publicStoreDescription)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        try! container.initializeCloudKitSchema()
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
