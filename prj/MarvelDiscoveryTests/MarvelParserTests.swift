//
//  MarvelParserTests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/9/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit
import XCTest

class MarvelParserTests: XCTestCase {

    func test_charactersParsing() {
        guard let charactersJSONPath = NSBundle.mainBundle().pathForResource("Characters", ofType: "json") else {
            return
        }
        let charactersString = try! String(contentsOfFile: charactersJSONPath)
        let charactersJSON = JSON(stringLiteral: charactersString)
        
        guard let parsedCharacters = Parser.sharedInstanse.parseCharactersArrayWithJSON(charactersJSON["data"]["results"]) else {
            XCTAssert(false, "Parser returns nil characters array")
            return
        }
        
        //Check for count: there only two characters in static json
        XCTAssertEqual(parsedCharacters.count, 2, "Parser returns incorrect character count")
        
        //Check properties for first character
        let threeDMan = parsedCharacters[0]

        //Character properties
        XCTAssertTrue(threeDMan.name == "3-D Man")
        XCTAssertTrue(threeDMan.resourceURI == "http://gateway.marvel.com/v1/public/characters/1011334")
        
        //Thumbnail image
        XCTAssertNil(threeDMan.thumbnailImage, "Thumbnail image nil")
        XCTAssertTrue(threeDMan.thumbnailImage?.imageExtension == "jpg")
        XCTAssertTrue(threeDMan.thumbnailImage?.urlPath == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        XCTAssertTrue(threeDMan.webURLs?.allObjects.count == 3)
        
        //Url links
        let urlLink = (threeDMan.webURLs?.allObjects as? [WebURL])?[0]
        XCTAssertNil(urlLink)
        XCTAssertTrue(urlLink?.url == "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=7316de942dede4504e98dc9dbd7bee5f")
        XCTAssertTrue(urlLink?.type == "detail")
        XCTAssertTrue(threeDMan.containedLists?.allObjects.count == 4)
        
        //Contents character
        let firstList = threeDMan.containedLists?.allObjects.first as? ContentsCharacter
        XCTAssertNil(firstList)
        
        XCTAssertTrue(firstList?.collectionURI == "http://gateway.marvel.com/v1/public/characters/1011334/events")
        XCTAssertTrue(firstList?.returnedCount == 1)
        XCTAssertTrue(firstList?.type == 2)
        XCTAssertTrue(firstList?.items?.allObjects.count == 1)
        
        //Event summary
        let eventSummary = firstList?.items?.allObjects.first as? ContentSummary
        XCTAssertNil(eventSummary)
        XCTAssertTrue(eventSummary?.name == "Secret Invasion")
        XCTAssertTrue(eventSummary?.resourceURI == "http://gateway.marvel.com/v1/public/events/269")
    }
}
