//
//  ContentsCharacter+CoreDataProperties.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ContentsCharacter {

    @NSManaged var type: NSNumber?
    @NSManaged var availableCount: NSNumber?
    @NSManaged var returnedCount: NSNumber?
    @NSManaged var collectionURI: String?
    @NSManaged var items: NSSet?
    @NSManaged var character: Character?

}
