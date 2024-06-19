//
//  StudentController.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import Foundation
import CoreData

class StudentController: ObservableObject {
    let container = PersistenceController.shared.container
    
    init() {
        print("hi students")
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data item saved!!")
        } catch {
            print("We couldnt save data.")
        }
    }
    func addStudent(name: String, state: String, email: String, country: String, doj: Date)-> UUID{
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
    }
}
