//
//  ContentsCharacter.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation
import CoreData

enum ContentsCharacterType : Int {
    case Comics = 0
    case Stories = 1
    case Events = 2
    case Series = 3
    case None = 4
    
    init?(string: String) {
        switch string.lowercaseString {
        case "comics":
            self.init(rawValue:0)
        case "stories":
            self.init(rawValue:1)
        case "events":
            self.init(rawValue:2)
        case "series":
            self.init(rawValue:3)
        default:
            return nil
        }
    }
    
    func toString() -> String {
        switch self {
        case .Comics:
            return "Comics"
        case .Stories:
            return "Stories"
        case .Events:
            return "Events"
        case .Series:
            return "Series"
        default:
            return ""
        }
    }
}


class ContentsCharacter: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}
