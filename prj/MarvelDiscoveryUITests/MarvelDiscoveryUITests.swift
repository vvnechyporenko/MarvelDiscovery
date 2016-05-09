//
//  MarvelDiscoveryUITests.swift
//  MarvelDiscoveryUITests
//
//  Created by winmons on 5/8/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import XCTest

class MarvelDiscoveryUITests: XCTestCase {
    let app = XCUIApplication()
    private var launched = false
    private let disableAnimationsForTesting = false
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        if disableAnimationsForTesting == true {
            app.launchEnvironment = ["animations": "0"]
            app.launch()
        }
        else {
            app.launch()
        }
    }
    
    func test_charactersListControllerShown() {
        XCTAssertNotNil(app.navigationBars["MarvelDiscovery.CharactersListView"], "Characters List controller is not shown")
    }
    
    func test_charactersSearch() {
        let marveldiscoveryCharacterslistviewNavigationBar = app.navigationBars["MarvelDiscovery.CharactersListView"]
        marveldiscoveryCharacterslistviewNavigationBar.buttons["icn nav search"].tap()
        
        let searchField = marveldiscoveryCharacterslistviewNavigationBar.searchFields.elementBoundByIndex(0)
        
        //Check search field exists
        XCTAssertNotNil(searchField, "Search field does not exists")
        //Check if search field is accessible
        XCTAssertTrue(searchField.hittable, "Search field is not accessible after search button tapped")
        
        searchField.typeText("Spider")
        
        //Check if the search did found correct character
        XCTAssertNotNil(app.tables.staticTexts["Spider-Man"], "Search did found correct character")
        
        app.tables.staticTexts["Spider-Man"].tap()
    }
    
    func test_characterDetailsControllerShown() {
        test_selectCharacterFromCharactersList()
        
        XCTAssertNotNil(app.navigationBars["MarvelDiscovery.CharacterDetailsView"], "Characters Details controller is not shown")
    }
    
    func test_popDetailsViewController() {
        test_characterDetailsControllerShown()
        
        let marveldiscoveryCharactersdetailsviewNavigationBar = app.navigationBars["MarvelDiscovery.CharacterDetailsView"]
        let backButton = marveldiscoveryCharactersdetailsviewNavigationBar.buttons["icn nav back white"]
        
        //Check back button accessible
        XCTAssertTrue(backButton.hittable, "Back button is not accessible in details controller")
        
        backButton.tap()
        
        test_charactersListControllerShown()
    }
    
    func test_cancelSearchResultsView() {
        let marveldiscoveryCharacterslistviewNavigationBar = app.navigationBars["MarvelDiscovery.CharactersListView"]
        
        marveldiscoveryCharacterslistviewNavigationBar.buttons["icn nav search"].tap()
        
        let searchField = marveldiscoveryCharacterslistviewNavigationBar.searchFields.elementBoundByIndex(0)
        let cancelButton = app.buttons["Cancel"]
     
        //Check cancel button accessible
        XCTAssertTrue(cancelButton.hittable, "Cancel search button is not accessible")
        
        cancelButton.tap()
        
        //Check if search field is not accessible any more
        XCTAssertFalse(searchField.hittable, "Search field is accessible after cancel search button tapped")
    }
    
    func test_topActivityIndicatorAppearance() {
        let firstCell = app.staticTexts["3-D Man"]
        let start = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 0))
        let finish = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 12))
        start.pressForDuration(0, thenDragToCoordinate: finish)
    }
    
    func test_selectCharacterFromCharactersList() {
        let cell = app.staticTexts["3-D Man"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectationForPredicate(exists, evaluatedWithObject: cell, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
        
        cell.tap()
    }
    
    func test_charactersEventsCoversPresent() {
        
        test_selectCharacterFromCharactersList()
        
        let tablesQuery = app.tables
        
        app.swipeUp()
        app.swipeUp()
        
        let firstEventCell = tablesQuery.tables.staticTexts["Avengers: The Initiative (2007) #18"]
        
        //Check first event exists in details controller
        XCTAssertNotNil(firstEventCell, "No events to select found")
        
        tablesQuery.tables.staticTexts["Avengers: The Initiative (2007) #18"].tap()
        
        let closeContentsButton = app.buttons["icn nav close white"]
        
        //Check contents viewer presented
        XCTAssertTrue(closeContentsButton.hittable, "Close contents button not accessible, contents controller not shown")
        
        closeContentsButton.tap()
        
        //Check contents viewer dismissed
        XCTAssertNotNil(app.navigationBars["MarvelDiscovery.CharacterDetailsView"], "Characters Details controller is not shown")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
