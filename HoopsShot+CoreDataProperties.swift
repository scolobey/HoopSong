//
//  HoopsShot+CoreDataProperties.swift
//  HoopSong
//
//  Created by Ryan on 5/31/23.
//
//

import Foundation
import CoreData


extension HoopsShot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoopsShot> {
        return NSFetchRequest<HoopsShot>(entityName: "HoopsShot")
    }

    @NSManaged public var name: String?
    @NSManaged public var sessions: NSOrderedSet?

}

// MARK: Generated accessors for sessions
extension HoopsShot {

    @objc(insertObject:inSessionsAtIndex:)
    @NSManaged public func insertIntoSessions(_ value: HoopsSession, at idx: Int)

    @objc(removeObjectFromSessionsAtIndex:)
    @NSManaged public func removeFromSessions(at idx: Int)

    @objc(insertSessions:atIndexes:)
    @NSManaged public func insertIntoSessions(_ values: [HoopsSession], at indexes: NSIndexSet)

    @objc(removeSessionsAtIndexes:)
    @NSManaged public func removeFromSessions(at indexes: NSIndexSet)

    @objc(replaceObjectInSessionsAtIndex:withObject:)
    @NSManaged public func replaceSessions(at idx: Int, with value: HoopsSession)

    @objc(replaceSessionsAtIndexes:withSessions:)
    @NSManaged public func replaceSessions(at indexes: NSIndexSet, with values: [HoopsSession])

    @objc(addSessionsObject:)
    @NSManaged public func addToSessions(_ value: HoopsSession)

    @objc(removeSessionsObject:)
    @NSManaged public func removeFromSessions(_ value: HoopsSession)

    @objc(addSessions:)
    @NSManaged public func addToSessions(_ values: NSOrderedSet)

    @objc(removeSessions:)
    @NSManaged public func removeFromSessions(_ values: NSOrderedSet)

}

extension HoopsShot : Identifiable {

}
