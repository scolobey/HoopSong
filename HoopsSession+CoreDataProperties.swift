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
    @NSManaged public var shot: NSOrderedSet?

}

// MARK: Generated accessors for shot
extension HoopsSession {

    @objc(insertObject:inShotAtIndex:)
    @NSManaged public func insertIntoShot(_ value: HoopsShot, at idx: Int)

    @objc(removeObjectFromShotAtIndex:)
    @NSManaged public func removeFromShot(at idx: Int)

    @objc(insertShot:atIndexes:)
    @NSManaged public func insertIntoShot(_ values: [HoopsShot], at indexes: NSIndexSet)

    @objc(removeShotAtIndexes:)
    @NSManaged public func removeFromShot(at indexes: NSIndexSet)

    @objc(replaceObjectInShotAtIndex:withObject:)
    @NSManaged public func replaceShot(at idx: Int, with value: HoopsShot)

    @objc(replaceShotAtIndexes:withShot:)
    @NSManaged public func replaceShot(at indexes: NSIndexSet, with values: [HoopsShot])

    @objc(addShotObject:)
    @NSManaged public func addToShot(_ value: HoopsShot)

    @objc(removeShotObject:)
    @NSManaged public func removeFromShot(_ value: HoopsShot)

    @objc(addShot:)
    @NSManaged public func addToShot(_ values: NSOrderedSet)

    @objc(removeShot:)
    @NSManaged public func removeFromShot(_ values: NSOrderedSet)

}

extension HoopsSession : Identifiable {

}
