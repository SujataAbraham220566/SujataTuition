//
//  Sessions+CoreDataProperties.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import CoreData

extension Sessions{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<Sessions>{
        return NSFetchRequest<Sessions>(entityName: "Sessions")
    }
    @NSManaged public var grade: String?
    @NSManaged public var sessionno: Int16
    @NSManaged public var subject: String?
    @NSManaged public var sessionid: UUID?
    @NSManaged public var studentid: UUID?
    @NSManaged public var password: String?
    //@NSManaged public var sessionToStudent: Set<Students>?
    
    /*public var students : Set<Students>{
        let setOfStudent = sessionToStudent
        return setOfStudent!
            //.sorted{
            //$0.sessionid > $1.sessionid
    }*/
}
extension Sessions{
    /*@objc(addStudentToSessionObject:)
    @NSManaged public func addStudentToSession(_ value: Students)
*/
}

extension Sessions: Identifiable{
    
}
