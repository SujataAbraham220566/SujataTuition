//
//  Session.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 04/08/23.
//

//
//  Student.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 04/08/23.
//
import Foundation
import CoreData

@objc(Sessions)
extension Sessions{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<Sessions>{
        return NSFetchRequest<Sessions>(entityName: "Sessions")
    }
    @NSManaged public var grade: String?
    @NSManaged public var sessionno: Int16
    @NSManaged public var subject: String?
    @NSManaged public var sessionid: UUID?
    @NSManaged public var studentid: UUID?

}

