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
    case Series = 1
    case Stories = 2
    case Events = 3
    case None = 4
    
    init?(string: String) {
        switch string.lowercaseString {
        case "comics":
            self.init(rawValue:ContentsCharacterType.Comics.rawValue)
        case "stories":
            self.init(rawValue:ContentsCharacterType.Series.rawValue)
        case "events":
            self.init(rawValue:ContentsCharacterType.Stories.rawValue)
        case "series":
            self.init(rawValue:ContentsCharacterType.Events.rawValue)
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
