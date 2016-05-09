//
//  MarvelCharacterDetailsManagerTests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/9/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import XCTest

class MarvelCharacterDetailsManagerTests: XCTestCase {

    func test_characterDetailsDatasourceGeneration() {
        // Set up data
        guard let charactersJSONPath = NSBundle.mainBundle().pathForResource("Characters", ofType: "json") else {
            return
        }
        let charactersString = try! String(contentsOfFile: charactersJSONPath)
        let charactersJSON = JSON(stringLiteral: charactersString)
        
        guard let character = Parser.sharedInstanse.parseCharactersArrayWithJSON(charactersJSON["data"]["results"])?.first else {
            return
        }
        
        let tableManager = CharacterDetailsTableViewManager()
        tableManager.character = character
        
        //Test generated data
        
        XCTAssertTrue(tableManager.cellModelsArray.count == 10)

        for (index, element) in tableManager.cellModelsArray.enumerate() {
            switch index {
            case 0:
                XCTAssertTrue(element.type == .Image)
                XCTAssertTrue(element.dataObject as? String == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
                break
            case 1:
                XCTAssertTrue(element.type == .Text)
                XCTAssertTrue(element.title == "NAME")
                XCTAssertTrue(element.dataObject as? String == "3-D Man")
                break
            case 2:
                XCTAssertTrue(element.type == .ContentsTableView)
                XCTAssertTrue(element.title == "Comics")
                let summaries = element.dataObject as? [ContentSummary]
                XCTAssertNil(summaries)
                XCTAssertTrue(summaries!.count == 11)
                break
            case 3:
                XCTAssertTrue(element.type == .ContentsTableView)
                XCTAssertTrue(element.title == "Series")
                let summaries = element.dataObject as? [ContentSummary]
                XCTAssertNil(summaries)
                XCTAssertTrue(summaries!.count == 17)
                break
            case 4:
                XCTAssertTrue(element.type == .ContentsTableView)
                XCTAssertTrue(element.title == "Stories")
                let summaries = element.dataObject as? [ContentSummary]
                XCTAssertNil(summaries)
                XCTAssertTrue(summaries!.count == 1)
                break
            case 5:
                XCTAssertTrue(element.type == .ContentsTableView)
                XCTAssertTrue(element.title == "Events")
                let summaries = element.dataObject as? [ContentSummary]
                XCTAssertNil(summaries)
                XCTAssertTrue(summaries!.count == 2)
                break
            case 6:
                XCTAssertTrue(element.type == .Title)
                XCTAssertTrue(element.title == "RELATED LINKS")
                break
            case 7:
                XCTAssertTrue(element.type == .Link)
                XCTAssertTrue(element.title == "Comiclink")
                XCTAssertNil(element.dataObject as? [WebURL])
                break
            case 8:
                XCTAssertTrue(element.type == .Link)
                XCTAssertTrue(element.title == "Detail")
                XCTAssertNil(element.dataObject as? [WebURL])
                break
            case 9:
                XCTAssertTrue(element.type == .Link)
                XCTAssertTrue(element.title == "Wiki")
                XCTAssertNil(element.dataObject as? [WebURL])
                break
            default:
                break
            }
        }
    }
}
