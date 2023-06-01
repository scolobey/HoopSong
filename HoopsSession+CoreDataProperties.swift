//
//  HoopsSession+CoreDataProperties.swift
//  HoopSong
//
//  Created by Ryan on 5/31/23.
//
//

import Foundation
import CoreData


extension HoopsSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoopsSession> {
        return NSFetchRequest<HoopsSession>(entityName: "HoopsSession")
    }

    @NSManaged public var attempts: Int16
    @NSManaged public var createdAt: Date?
    @NSManaged public var makes: Int16
    @NSManaged public var shot: HoopsShot?

}

extension HoopsSession : Identifiable {

}
