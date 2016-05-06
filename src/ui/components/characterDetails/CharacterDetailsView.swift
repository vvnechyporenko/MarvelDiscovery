//
//  CharacterDetailsView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterDetailsView: BaseView {
    let tableView = BaseTableView()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        addSubview(tableView)
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        tableView.autoPinEdgesToSuperviewEdges()
    }
}
