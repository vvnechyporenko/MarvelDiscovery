//
//  NetworkCharactersRequests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation

let kCharactersLimitCount = 40

extension NetworkManager {
    func getCharactersWithOffset(offset : Int,
                              filterName : String? = nil,
                              complete : (characters : [Character]?, totalCount : Int?, error : NSError?) -> Void) {
        
        var params = [String : AnyObject]()
        if let filterName = filterName {
            params["name"] = filterName
        }
        params["limit"] = kCharactersLimitCount
        if offset > 0 {
            params["offset"] = offset
        }
        
        sendRequestWithPath("characters", method: .GET, params: params) { (JSON, error) in
            if let error = error {
                complete(characters: nil, totalCount: nil, error: error)
            }
            else if let json = JSON {
                complete(characters: Parser.sharedInstanse.parseCharactersArrayWithJSON(json["results"]), totalCount: json["total"].int, error: nil)
            }
            else {
                complete(characters: nil, totalCount: nil, error: NSError.defaultError())
            }
        }
    }
}