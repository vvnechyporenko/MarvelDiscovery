//
//  Character+CoreDataProperties.swift
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

extension Character {

    @NSManaged var identifier: NSNumber?
    @NSManaged var name: String?
    @NSManaged var charcterDescription: String?
    @NSManaged var resourceURI: String?
    @NSManaged var webURLs: NSSet?
    @NSManaged var thumbnailImage: ThumbnailImage?
    @NSManaged var containedLists: NSSet?

}
