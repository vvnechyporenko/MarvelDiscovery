//
//  Baseswift
//  YouBetMe
//
//  Created by Slava Nechiporenko on 8/20/15.
//  Copyright (c) 2015 Prophonix. All rights reserved.
//

import UIKit

protocol TableViewRefreshDelegate : class {
    func tableView(tableView : BaseTableView, asksReloadWithControl refreshControl : UIRefreshControl)
}

class BaseTableView: UITableView {
    
    var topRefreshControl = UIRefreshControl()
    var bottomActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    weak var refreshDelegate : TableViewRefreshDelegate?
    
    init() {
        super.init(frame : CGRectZero, style : .Plain)
        baseSetUp()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style : style)
        baseSetUp()
    }
    
    func baseSetUp() {
        backgroundColor = UIColor.clearColor()
        separatorColor = UIColor.clearColor()
    }
    
    func setUpRefreshControls() {
        topRefreshControl.addTarget(self, action: #selector(BaseTableView.tableViewTopRefreshControlActivated), forControlEvents: .ValueChanged)
        addSubview(topRefreshControl)
        topRefreshControl.tintColor = .whiteColor()
        
        bottomActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        
        bottomActivityIndicator.hidden = true
        bottomActivityIndicator.transform = CGAffineTransformMakeScale(0.8, 0.8)
        bottomActivityIndicator.tintColor = .whiteColor()
        bottomActivityIndicator.hidesWhenStopped = true
    }
    
    //set up bottom refresh control after move to superview, to avoid constraints set up errors
    override func didMoveToSuperview() {
        superview?.insertSubview(bottomActivityIndicator, atIndex: 0)
        bottomActivityIndicator.autoAlignAxis(.Vertical, toSameAxisOfView: self)
        bottomActivityIndicator.autoPinEdgeToSuperviewEdge(.Top, withInset: screenHeight() - 50 - navigationBarHeight())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tableViewTopRefreshControlActivated() {
        refreshDelegate?.tableView(self, asksReloadWithControl: topRefreshControl)
    }
}