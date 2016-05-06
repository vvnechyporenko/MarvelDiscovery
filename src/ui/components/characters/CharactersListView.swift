//
//  CharactersListView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation
import UIKit

class CharactersListView: BaseView {
    let tableView = BaseTableView()
    
    override func setUpDefaults() {
        tableView.setUpRefreshControls()
        addSubview(tableView)
        backgroundColor = MDColors.charactersListBackgroundColor()
    }
    
    override func setUpConstraints() {
        tableView.autoPinEdgesToSuperviewEdges()
    }
    

}