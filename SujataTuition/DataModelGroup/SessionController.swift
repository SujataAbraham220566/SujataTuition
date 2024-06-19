//
//  SessionController.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import Foundation
import CoreData

class SessionController: ObservableObject{
    let container = PersistenceController.shared.container
    
    init(){
        print("hi session")
        print("end session")
    }
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data item saved!!")
        } catch {
            print("We couldnt save data.")
        }
    }
    func addSession(grade: String, subject: String, sessionno: Int16, studentid: UUID, password: String){
        //, context: NSManagedObjectContext){
        //let item = Items()
        let session = Sessions(context: container.viewContext)
        session.sessionid = UUID()
        session.grade = grade
        session.subject = subject
        session.sessionno = sessionno
        session.studentid = studentid
        session.password = password
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    func editSession(session: Sessions, grade: String, subject: String, sessionno: Int16, studentid: UUID, password: String){
        //let session = Sessions(context: container.viewContext)
        session.grade = grade
        session.subject = subject
        session.sessionno = sessionno
        session.password = password
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func getAllSessions() -> [Sessions]{
        let fetchRequest: NSFetchRequest<Sessions> = Sessions.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "sessionid" + "subject" + "grade", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func filteredSessions(passwd: String) -> [Sessions]{
        let fetchRequest: NSFetchRequest<Sessions> = Sessions.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "subject"+"grade", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "password == %@", "\(passwd)")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    
    func deleteSession(session: Sessions){
        container.viewContext.delete(session)
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateSession(){
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
}
