//
//  Persistence.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import CoreData
import CloudKit
import OSLog

private let logger = Logger.init(subsystem: "SujataTuition", category: "PersistenceController")

class PersistenceController {
    static let shared = PersistenceController()

    let container = NSPersistentCloudKitContainer(name: "Model4")

    init() {
        // Private
        let privateStoreDescription = container.persistentStoreDescriptions.first!
        privateStoreDescription.configuration = "Private"
        let storesURL = privateStoreDescription.url!.deletingLastPathComponent()
        privateStoreDescription.url = storesURL.appendingPathComponent("private.sqlite")
        privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        privateStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        // Public
        let publicStoreDescription = NSPersistentStoreDescription(url: storesURL.appendingPathComponent("public.sqlite"))
        publicStoreDescription.configuration = "Public"
//        publicStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
//        publicStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        publicStoreDescription.cloudKitContainerOptions = .init(containerIdentifier: privateStoreDescription.cloudKitContainerOptions!.containerIdentifier)
        publicStoreDescription.cloudKitContainerOptions!.databaseScope = .public
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
        
//        let privateStore = container.persistentStoreCoordinator.persistentStores[0]
//        let publicStore = container.persistentStoreCoordinator.persistentStores[1]
//        print("configurationName: \(String(describing: publicStore.configurationName))")
//        print("isReadOnly: \(String(describing: publicStore.isReadOnly))")
//
//        print("canModifyMOs: \(container.canModifyManagedObjects(in: publicStore))")
//        print("canModifyMOs: \(container.canModifyManagedObjects(in: container.persistentStoreCoordinator.persistentStores[0]))")
//        
//        try! container.initializeCloudKitSchema()
        
        logger.log("viewContext: \(self.container.viewContext)")
        container.viewContext.automaticallyMergesChangesFromParent = true
//        
//        let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: container.viewContext) as! Course
//        course.id = "com.SujataTuition.SixthChemistry"
//        let chapter = NSEntityDescription.insertNewObject(forEntityName: "Chapter", into: container.viewContext) as! Chapter
//        chapter.name = "hi2"
//        course.chapters = [ chapter ]
//        do {
//            try container.viewContext.save()
//        } catch {
//            // Handle the error appropriately.
//            print("Failed to save the context:", error.localizedDescription)
//        }
    }

    func video(forChapterWithName name: String) -> AsyncThrowingStream<LoadingState<URL>, any Error> {
        AsyncThrowingStream { continuation in
            Task.detached {
                let directory = NSTemporaryDirectory()
                let fileName = "\(name).m4v"
                //let fileName = "\(video(forChapterWithName: name))"
                let destinationURL = NSURL.fileURL(withPathComponents: [directory, fileName])!

                if FileManager.default.fileExists(atPath: destinationURL.path(percentEncoded: false)) {
                    continuation.yield(.loaded(destinationURL))
                    continuation.finish()
                    return
                }
                
                let publicDatabase = CKContainer.default().publicCloudDatabase
                let query = CKQuery(recordType: "Video", predicate: .init(format: "name == %@", name))
                do {
                    let (results, _) = try await publicDatabase.records(matching: query, desiredKeys: [], resultsLimit: 1)
                    guard let recordID = results.first?.0 else {
                        continuation.finish(throwing: NSError(domain: "com.apple.SujataTuition.RecordNotFound", code: 0xDEAD))
                        return
                    }
                    
                    let fetchRecordsOp = CKFetchRecordsOperation(recordIDs: [ recordID ])
                    fetchRecordsOp.desiredKeys = [ "asset" ]
                    fetchRecordsOp.perRecordProgressBlock = { _, progress in
                        // 99.9% hack: if cancellation occurs before `perRecordResultBlock`, we could start another `fetchRecordsOp`
                        if case .terminated = continuation.yield(.loading(progress)) {
                            fetchRecordsOp.cancel()
                        }
                    }
                    fetchRecordsOp.perRecordResultBlock = { _, result in
                        if case .failure(let error) = result {
                            continuation.finish(throwing: error)
                            return
                        }
                        
                        guard case .success(let record) = result, let asset = record["asset"] as? CKAsset else {
                            continuation.finish(throwing: NSError(domain: "com.apple.SujataTuition.NotAnAsset", code: 0xDEAD))
                            return
                        }
                        
                        guard let URL = asset.fileURL else {
                            continuation.finish(throwing: NSError(domain: "com.apple.SujataTuition.NoAsset", code: 0xDEAD))
                            return
                        }

                        do {
                            try FileManager.default.moveItem(at: URL, to: destinationURL)
                        } catch {
                            continuation.finish(throwing: error)
                        }
                        
                        continuation.yield(.loaded(destinationURL))
                        continuation.finish()
                    }
                    publicDatabase.add(fetchRecordsOp)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
