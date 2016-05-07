//
//  CharactersSearchView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharactersSearchView: CharactersListView {
    var constraintBottomTableView : NSLayoutConstraint?
    
    override func setUpDefaults() {
        super.setUpDefaults()
        backgroundColor = MDColors.blackColor()
        alpha = 0
        
        tableView.topRefreshControl.enabled = false
        tableView.topRefreshControl.removeFromSuperview()
        tableView.backgroundColor = MDColors.charactersListBackgroundColor()
        tableView.separatorColor = MDColors.cellSeparatorColor()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    override func setUpConstraints() {
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        tableView.autoPinEdgeToSuperviewEdge(.Top)
        constraintBottomTableView = tableView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
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
