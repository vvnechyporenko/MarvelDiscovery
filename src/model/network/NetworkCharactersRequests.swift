//
//  NetworkCharactersRequests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation


extension NetworkManager {
    func getCharactersForPage(page : Int,
                              filterName : String? = nil,
                              complete : (characters : [Character]?, error : NSError?) -> Void) {
        
        var params = [String : AnyObject]()
        if let filterName = filterName {
            params["name"] = filterName
        }
        
        sendRequestWithPath("characters", method: .GET, params: params) { (JSON, error) in
            if let error = error {
                complete(characters: nil, error: error)
            }
            else if let json = JSON {
                complete(characters: Parser.sharedInstanse.parseCharactersArrayWithJSON(json), error: nil)
            }
            else {
                complete(characters: nil, error: NSError.defaultError())
            }
        }
    }
}