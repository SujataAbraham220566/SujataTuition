//
//  PwdFile+CoreDataProperties.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import CoreData

extension PwdFile{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<PwdFile>{
        return NSFetchRequest<PwdFile>(entityName: "PwdFile")
    }
    @NSManaged public var pwd: String?
    @NSManaged public var id: UUID?
}

extension PwdFile: Identifiable{
    
}
