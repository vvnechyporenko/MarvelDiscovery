//
//  Parser.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation

class Parser: AnyObject {
    static let sharedInstanse = Parser()
    
    func parseCharactersArrayWithJSON(json : JSON?) -> [Character]? {
        guard let jsonArray = json?.array else {
            return nil
        }
        
        return jsonArray.map({ return parseCharacterJSON($0) })
    }
    
    func parseCharacterJSON(json : JSON) -> Character {
        let character = Character.MR_createEntity()
        
        guard let identifier = json["id"].number else {
            return character
        }
        
        character.identifier = identifier
        character.name = json["name"].string
        character.charcterDescription = json["description"].string
        character.resourceURI = json["resourceURI"].string
        
        parseWebURLsArray(json["urls"].array, forCharacter: character)
        parseThumbnailJSON(json["thumbnail"], forCharacter: character)
        parseContentsJSON(json["comics"], type: ContentsCharacterType(string: "comics"), forCharacter: character)
        parseContentsJSON(json["stories"], type: ContentsCharacterType(string: "stories"), forCharacter: character)
        parseContentsJSON(json["events"], type: ContentsCharacterType(string: "events"), forCharacter: character)
        parseContentsJSON(json["series"], type: ContentsCharacterType(string: "series"), forCharacter: character)
        
        return character
    }
    
    func parseWebURLsArray(jsonArray : [JSON]?, forCharacter character : Character) {
        guard let jsonArray = jsonArray else {
            return
        }
        
        for json in jsonArray {
            let webURL = WebURL.MR_createEntity()
            webURL.url = json["url"].string
            webURL.type = json["type"].string
            webURL.character = character
        }
    }
    
    func parseThumbnailJSON(json : JSON?, forCharacter character : Character?) -> ThumbnailImage? {
        guard let json = json else {
            return nil
        }
        
        let thumbnail = ThumbnailImage.MR_createEntity()
        thumbnail.imageExtension = json["extension"].string
        thumbnail.urlPath = json["path"].string
        thumbnail.character = character
        
        return thumbnail
    }
    
    func parseContentsJSON(json : JSON?, type : ContentsCharacterType?, forCharacter character : Character) {
        guard let json = json else {
            return
        }
        
        let contents = ContentsCharacter.MR_createEntity()
        contents.character = character
        contents.type = type?.rawValue
        contents.availableCount = json["available"].number
        contents.returnedCount = json["returned"].number
        contents.collectionURI = json["collectionURI"].string
        
        guard let items = json["items"].array else {
            return
        }
        
        for element in items {
            let summary = ContentSummary.MR_createEntity()
            summary.holder = contents
            summary.name = element["name"].string
            summary.resourceURI = element["resourceURI"].string
            summary.type = element["type"].string
        }
    }
    
    func parseImageURLFromResourceJSON(json : JSON?) -> String? {
        guard let json = json else {
            return nil
        }
        
        return parseThumbnailJSON(findValueForKey("thumbnail", inJSON: json), forCharacter: nil)?.downloadURL
    }
    
    func findValueForKey(key : String, inJSON json : JSON) -> JSON? {
        
        if let _ = json[key].dictionary {
            return json[key]
        }
        
        if let dictionary = json.dictionary {
            let array = Array(dictionary.keys)
            for keyElement in array {
                if let value = findValueForKey(key, inJSON: json[keyElement]) {
                    return value
                }
            }
        }
        
        if let array = json.array {
            for element in array {
                if let value = findValueForKey(key, inJSON: element) {
                    return value
                }
            }
        }
        
        return nil
    }
}