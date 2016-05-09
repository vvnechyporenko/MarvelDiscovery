//
//  MarvelNetworkTests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/9/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import XCTest

class MarvelNetworkTests: XCTestCase {
    func test_networkCharactersLoading() {
        NetworkManager.sharedInstance.getCharactersWithOffset(0) { (characters, totalCount, filterName, error) in
            XCTAssertTrue(characters?.count != Constants.CharactersRequestLimitCount)
        }
    }
    
    func test_networkAuthentification() {
        NetworkManager.sharedInstance.getCharactersWithOffset(0) { (characters, totalCount, filterName, error) in
            XCTAssertTrue(error?.code == ErrorCodeType.Unauthorized.rawValue)
        }
    }
    
    func test_networkCharactersSearch() {
        let filterName = "Spider"
        NetworkManager.sharedInstance.getCharactersWithOffset(0, filterName: filterName) { (characters, totalCount, filterName, error) in
            XCTAssertNil(characters)
            guard let characters = characters else {
                return
            }
            XCTAssertTrue(characters.count == 0)
            for character in characters {
                XCTAssertNil(character.name)
                if let name = character.name, let filterName = filterName {
                    XCTAssertTrue(!name.hasPrefix(filterName))
                }
            }
        }
    }
}
