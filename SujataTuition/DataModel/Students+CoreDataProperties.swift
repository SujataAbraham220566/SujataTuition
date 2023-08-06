//
//  Student.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 04/08/23.
//
import Foundation
import CoreData
import UIKit

@objc(Students)
extension Students{
    @nonobjc public class func fetchRequest()-> NSFetchRequest<Students>{
        return NSFetchRequest<Students>(entityName: "Students")
    }
    @NSManaged public var doj: Date?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var photo: UIImage?
    @NSManaged public var studentid: UUID?

}
