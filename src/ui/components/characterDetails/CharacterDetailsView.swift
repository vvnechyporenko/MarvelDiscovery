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
    let titleLabel = UILabel()
    private var topBlurBar : UIVisualEffectView?
    
    override func setUpDefaults() {
        super.setUpDefaults()
        backgroundColor = MDColors.charactersListBackgroundColor()
        addSubview(tableView)
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        //Set up top bar
        let blurEffect = UIBlurEffect(style: .Dark)
        topBlurBar = UIVisualEffectView(effect: blurEffect)
        topBlurBar?.alpha = 0
        addSubview(topBlurBar!)
        
        topBlurBar?.addSubview(titleLabel)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        
        //Scroll view observer
        tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New.union(.Old), context: nil)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        tableView.autoPinEdgesToSuperviewEdges()
        topBlurBar?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Bottom)
        topBlurBar?.autoSetDimension(.Height, toSize: navigationBarHeight())
        
        titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30))
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentOffset", context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        UIView.animateWithDuration(0.2) {
            self.topBlurBar?.alpha = self.tableView.contentOffset.y > 20 ? 1 : 0
        }
    }
}
