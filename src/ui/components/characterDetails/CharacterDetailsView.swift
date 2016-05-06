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
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        tableView.autoPinEdgesToSuperviewEdges()
    }
}
