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
    @NSManaged public var sessions: NSSet?

    public var sessionArray: [HoopsSession] {
        let sessionSet = sessions as? Set<HoopsSession> ?? []
        
        // Set a default date for 20 years ago, and hopefully this never gets used
        // because the date should be set from the beginning.
        let defaultDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())
        
        return sessionSet.sorted(by: { $0.createdAt?.compare((($1.createdAt ?? defaultDate)!)) == .orderedDescending })
    }
}

// MARK: Generated accessors for sessions
extension HoopsShot {

    @objc(addSessionsObject:)
    @NSManaged public func addToSessions(_ value: HoopsSession)

    @objc(removeSessionsObject:)
    @NSManaged public func removeFromSessions(_ value: HoopsSession)

    @objc(addSessions:)
    @NSManaged public func addToSessions(_ values: NSSet)

    @objc(removeSessions:)
    @NSManaged public func removeFromSessions(_ values: NSSet)

}

extension HoopsShot : Identifiable {

}
