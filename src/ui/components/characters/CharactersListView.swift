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
    
    func animateLoading() {
        tableView.contentOffset = CGPoint(x: 0, y: tableView.topRefreshControl.frame.size.height)
        tableView.topRefreshControl.beginRefreshing()
    }
    
    func animateBottomLoading() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tableView.topRefreshControl.frame.size.height, right: 0)
        tableView.bottomActivityIndicator.hidden = false
        tableView.bottomActivityIndicator.startAnimating()
    }
    
    func endLoading() {
        tableView.topRefreshControl.endRefreshing()
        tableView.bottomActivityIndicator.stopAnimating()
        tableView.bottomActivityIndicator.hidden = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}