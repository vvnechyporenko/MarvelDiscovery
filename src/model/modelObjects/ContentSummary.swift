//
//  ContentSummary.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation
import CoreData


class ContentSummary: NSManagedObject {

    func imageURL(complete : (imageURL : String?) -> Void) {
        if let imageURL = imageURL {
            complete(imageURL: imageURL)
            return
        }
        guard let resourceURI = resourceURI else {
            complete(imageURL: nil)
            return
        }
        
        NetworkManager.sharedInstance.getImageUrlForResourceURI(resourceURI) {[weak self] (imageURL) in
            self?.imageURL = imageURL
            complete(imageURL: imageURL)
        }
    }
}
