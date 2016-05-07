//
//  CharacterContentsDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterContentsDetailsTableViewCell: CharacterBaseDetailsTableViewCell {
    let tableView = EasyTableView(frame: CGRect(x: 12, y: 30, width: screenWidth()-12*2, height: 210), ofWidth: 114)
    let tableManager = CharacterContentsTableViewManager()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        
        containerView.addSubview(tableView)
        tableView.tableView.separatorColor = .clearColor()
        tableView.backgroundColor = .clearColor()
        tableView.tableView.backgroundColor = .clearColor()
        tableView.clipsToBounds = false
        tableView.tableView.clipsToBounds = false
        
        tableView.delegate = tableManager
        tableManager.contentTableView = tableView
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        titleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 200)
    }
}
