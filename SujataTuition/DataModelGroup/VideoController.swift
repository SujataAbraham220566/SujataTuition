//
//  VideoController.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 14/06/24.
//

import Foundation
import SwiftUI
import CoreData
import CloudKit

class VideoController: ObservableObject{
    let container = PersistenceController.shared.container
    
    init(){
        print("hi videos")
        /*let newVideo = VideoFiles(context: container.viewContext)

        //let newVideo = CKRecord(recordType: "Videofiles")
        //newVideo("name") = nam
        guard //let video = AVV  ("Maths6Chapter1.m4v"), //"Maths6Chapter1"),
              let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.itemReplacementDirectory, in: .userDomainMask).first?.appendingPathComponent("Maths6Chapter1.m4v")
              //let data = video
        else { return }
        //do { try data.write(to: url)
            let asset = CKAsset(fileURL: url)
        newVideo.videoUrl = CKAsset(fileURL: url)
        newVideo.name = "Maths6Chap1"
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
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
}
