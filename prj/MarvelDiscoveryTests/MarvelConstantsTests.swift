//
//  MarvelConstantsTests.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/9/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import XCTest

class MarvelConstantsTests: XCTestCase {
    
    func test_publicKeyLength() {
        let key = Constants.ApiPublicKey
        XCTAssertEqual(key.characters.count, 32)
    }
    
    func test_privateKeyLenght() {
        let key = Constants.ApiPrivateKey
        XCTAssertEqual(key.characters.count, 40)
    }
    
}
