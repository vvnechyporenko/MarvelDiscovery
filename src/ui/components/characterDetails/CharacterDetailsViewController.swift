//
//  CharacterDetailsViewController.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: BaseViewController {
    private let contentView = CharacterDetailsView()
    var character : Character?
    
    override func loadView() {
        super.loadView()
        
        layoutContentView(contentView)
    }
}
