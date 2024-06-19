//
//  VideoManager.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 11/06/24.
//

import SwiftUI
import Foundation
import CoreData
import CloudKit
import AVFoundation

class VideoManager: ObservableObject{
    let container = NSPersistentCloudKitContainer(name: "StudentModel")
    init() async{
        print("hi videos")
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("failed to load the data \(error.localizedDescription)")
            }
        }
        let newVideo = CKRecord(recordType: "Videofiles")
        //newVideo("name") = nam
        guard //let video = AVV  ("Maths6Chapter1.m4v"), //"Maths6Chapter1"),
            let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.itemReplacementDirectory, in: .userDomainMask).first?.appendingPathComponent("Maths6Chapter1.m4v")
                //let data = video
        else { return }
        //do { try data.write(to: url)
        _ = CKAsset(fileURL: url)
        newVideo["videoUrl"] = CKAsset(fileURL: url)
        newVideo["name"] = "Maths6Chap1"
        //await saveItem(record: newVideo)
        /*} catch let error {
         print(error)
         }*/
    }
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data item saved!!")
        } catch {
            print("We couldnt save data.")
        }
    }
    /*func addStudent(name: String, state: String, email: String, country: String, doj: Date)-> UUID{
     //, context: NSManagedObjectContext){
     //let item = Items()
     let student = Students(context: container.viewContext)
     student.studentid = UUID()
     student.name = name
     student.state = state
     student.email = email
     student.country = country
     student.doj = doj
     //save(context: context)
     do{
     try container.viewContext.save()
     } catch {
     container.viewContext.rollback()
     }
     return student.studentid!
     }
     
     func editstudent(student: Students, name: String, state: String, email: String, country: String, doj: Date){
     //let student = Students(context: container.viewContext)
     student.name = name
     student.state = state
     student.email = email
     student.country = country
     student.doj = doj
     //save(context: context)
     do{
     try container.viewContext.save()
     } catch {
     container.viewContext.rollback()
     }
     }
     
     func getAllStudents() -> [Students]{
     let fetchRequest: NSFetchRequest<Students> = Students.fetchRequest()
     //predicate: NSPredicate(format: "password == passwd")
     //)
     do {
     return try container.viewContext.fetch(fetchRequest)
     } catch {
     return []
     }
     }
     
     func deleteStudent(student: Students){
     container.viewContext.delete(student)
     do {
     try container.viewContext.save()
     } catch {
     container.viewContext.rollback()
     print("Failed to save context \(error)")
     }
     }
     
     func updateStudent(){
     do{
     try container.viewContext.save()
     } catch {
     container.viewContext.rollback()
     }
     }*/
    /*func saveItem(record: CKRecord) async{
     CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
     print("Record: \(returnedRecord)")
     print("Error: \(returnedError ?? Error))")
     //DispatchQueue.main.async{
     //self?.text = ""
     //  self?.fetchItems()
     }
     }
     }*/
    /*func fetchItems(){
     let predicate = NSPredicate(value: true)
     let query = CKQuery(recordType: "VideoFiles", predicate: predicate)
     query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
     let queryOperation = CKQueryOperation(query: query)
     var returnedItems: [String] = []
     if available (iOS 15.0, *){
     queryOperation.recordMatchedBlock = {(returnedRecordID, returnedResult) in
     switch returnedResult{
     case .success(let record):
     guard let name = record("name") as? String else {return}
     returnedItems.append(VideoFiles(name: name, record: record))
     case .failure(let error):
     print("Error recordMatchedBlock: \(error)")
     }
     }
     } else {
     queryOperation.recordFetchedBlock = {(returnedRecord) in
     guard let name = returnedRecord("name") as? String else {return}
     returnedItems.append(VideoFiles(name: name, record: returnedRecord))
     }
     }
     if #available (iOS 15.0, *){
     queryOperation.queryResultBlock = { [weak self]
     returnedResult in
     print("RETURNED query Result Block: \(returnedResult)")
     }
     DispatchQueue.main.async{
     self.VideoFiles = returnedItems
     }
     } else {
     queryOperation.queryCompletionBlock = [weak self] (returnedResult, returnedError) in
     print("RETURNED query Completion Block")
     DispatchQueue.main.async{
     self?.VideoFiles = returnedItems
     }
     }
     addOperation(opertion: CKDatabaseOperation)
     }
     func addOperation(operation: CKDatabaseOperation){
     CKContainer.default().publicCloudDatabase.add(operation)
     }
     func updateItem(VidoFiles: VideoModel){
     let record = VideoFiles.record
     record["name"] = "NEWName!!"
     saveItem(record: record)
     }*/
    /*func deleteItem(indexSet: IndexSet){
     guard let index IndexSet.first else { return }
     let VideoFile = VideoFiles[index]
     let record = VideoFile.record
     CKContainer.default().publicCloudDatabase(withRecordID: record.recordID){ [weak self] returnedID, returnedError in
     DispatchQueue.main.async{
     self?.VideoFiles.remove(at: Index)
     }
     }
     }*/
    
}
