//
//  CharactersSearchView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharactersSearchView: CharactersListView {
    let searchBar = UISearchBar()
    var constraintBottomTableView : NSLayoutConstraint?
    
    override func setUpDefaults() {
        super.setUpDefaults()
        backgroundColor = MDColors.blackColor()
        alpha = 0
        addSubview(searchBar)
        
        searchBar.tintColor = MDColors.redColor()
        searchBar.backgroundImage = MDColors.blackColor().toImage()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search...".localized()
        searchBar.enableCancelButton()
        
        tableView.topRefreshControl.enabled = false
        tableView.backgroundColor = MDColors.charactersListBackgroundColor()
        tableView.separatorColor = MDColors.cellSeparatorColor()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    override func setUpConstraints() {
        searchBar.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: statusBarHeight(), left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
        constraintBottomTableView = tableView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
    }
    
    func reverseHiddenState() {
        UIView.animateWithDuration(0.33) { 
            self.alpha = self.alpha == 0 ? 1 : 0
        }
    }
}

// MARK: Keyboard protocol

extension CharactersSearchView : KeyboardChangesProtocol {
    func keyboardWillShowWithSize(keyboardSize: CGSize) {
        constraintBottomTableView?.constant = -keyboardSize.height
        animateSetNeedsLayout()
    }
    
    func keyboardWillHide() {
        constraintBottomTableView?.constant = 0
        animateSetNeedsLayout()
    }
}
