//
//  CharacterContentsDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterContentsDetailsTableViewCell: CharacterBaseDetailsTableViewCell {
//    let tableView = EasyTableView(frame: CGRect(elementsOffset, elementsOffset, screenWidth()-elementsOffset*2, 175), ofWidth: 114)
    
    let tableView = EasyTableView(frame: CGRectZero, ofWidth: 114)
    
    override func setUpDefaults() {
        super.setUpDefaults()
        
        addSubview(tableView)
        tableView.tableView.separatorColor = .clearColor()
        tableView.backgroundColor = .clearColor()
        tableView.tableView.backgroundColor = .clearColor()
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        tableView.autoSetDimension(.Height, toSize: 175)
    }
}
