//
//  Students+CoreDataProperties.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//
import Foundation
import CoreData
import UIKit

extension Students{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<Students>{
        return NSFetchRequest<Students>(entityName: "Students")
    }
    /*@nonobjc public class func fetchRequest()-> NSFetchRequest<Sessions>{
        return NSFetchRequest<Sessions>(entityName: "Sessions")
    }*/

    @NSManaged public var doj: Date
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var studentid: UUID?
    /*@NSManaged public var studentToSession: Set<Sessions>?
    
    public var sessions : Set<Sessions>{
        let setOfSession = studentToSession
        return setOfSession!
            //.sorted{
            //$0.sessionid > $1.sessionid
    }*/
}
extension Students{
   /* @objc(addSessionToStudentObject:)
    @NSManaged public func addSessionToStudent(_ value: Sessions)
*/
}
extension Students: Identifiable{
    
}
 


