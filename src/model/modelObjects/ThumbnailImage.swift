//
//  ThumbnailImage.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation
import CoreData


class ThumbnailImage: NSManagedObject {
    
    var downloadURL : String? {
        if let url = urlPath, let extens = imageExtension {
            return url + "." + extens
        }
        return nil
    }

// Insert code here to add functionality to your managed object subclass

}
