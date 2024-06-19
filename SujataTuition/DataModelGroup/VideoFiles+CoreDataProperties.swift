//
//  VideoFiles+CoreDataProperties.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 14/06/24.
//

import Foundation
import CoreData
import CloudKit

extension VideoFiles{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<VideoFiles>{
        return NSFetchRequest<VideoFiles>(entityName: "VideoFiles")
    }
    @NSManaged public var name: String?
    @NSManaged public var videoUrl: CKAsset
    //@NSManaged public var sessionToStudent: Set<Students>?
    
    /*public var students : Set<Students>{
        let setOfStudent = sessionToStudent
        return setOfStudent!
            //.sorted{
            //$0.sessionid > $1.sessionid
    }*/
}
extension VideoFiles{
    /*@objc(addStudentToSessionObject:)
    @NSManaged public func addStudentToSession(_ value: Students)
*/
}

extension VideoFiles: Identifiable{
    
}
