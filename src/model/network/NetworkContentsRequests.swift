//
//  NetworkContentsRequests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/7/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation


extension NetworkManager {
    func getImageUrlForResourceURI(resourceURI : String, complete : (imageURL : String?) -> Void) {
        sendRequestWithPath(resourceURI, method: .GET, params: nil) { (JSON, error) in
            if let _ = error {
                complete(imageURL: nil)
            }
            else {
                complete(imageURL: Parser.sharedInstanse.parseImageURLFromResourceJSON(JSON))
            }
        }
    }
}