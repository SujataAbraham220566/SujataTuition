//
//  PwdController.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import Foundation
import CoreData

class PwdController: ObservableObject{
    let container = PersistenceController.shared.container
    
    init(){
        print("hi pwd")
    }
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("pwd saved!!")
        } catch {
            print("We couldnt save pwd.")
        }
    }
    func addPwd(pwd: String, id: UUID){
        //, context: NSManagedObjectContext){
        //let item = Items()
        let pwdFile = PwdFile(context: container.viewContext)
        pwdFile.pwd = pwd
        pwdFile.id = id
        //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func editPwd(pwdFile: PwdFile, pwd: String){
        //let student = Students(context: container.viewContext)
        pwdFile.pwd = pwd
        //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func getAllpwd() -> [PwdFile]{
        let fetchRequest: NSFetchRequest<PwdFile> = PwdFile.fetchRequest()
             //predicate: NSPredicate(format: "password == passwd")
        //)
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deletePwdFile(pwdFile: PwdFile){
        container.viewContext.delete(pwdFile)
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updatePwdFile(){
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
}
