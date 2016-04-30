//
//  BaseTableView.swift
//  YouBetMe
//
//  Created by Slava Nechiporenko on 8/20/15.
//  Copyright (c) 2015 Prophonix. All rights reserved.
//

import UIKit

protocol TableViewRefreshDelegate : class {
    func tableView(tableView : BaseTableView, asksNewLoadNewPageWithControl refreshControl : UIRefreshControl)
    func tableView(tableView : BaseTableView, asksReloadWithControl refreshControl : UIRefreshControl)
}

class BaseTableView: UITableView {
    
    var topRefreshControl = UIRefreshControl()
    var bottomActivityIndicator : UIActivityIndicatorView?
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
        
        topRefreshControl.addTarget(self, action: #selector(BaseTableView.tableViewTopRefreshControlActivated), forControlEvents: .ValueChanged)
        addSubview(topRefreshControl)
        topRefreshControl.tintColor = .whiteColor()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tableViewBottomRefreshControlActivated() {
        refreshDelegate?.tableView(self, asksNewLoadNewPageWithControl: topRefreshControl)
    }
    
    @objc private func tableViewTopRefreshControlActivated() {
        refreshDelegate?.tableView(self, asksReloadWithControl: topRefreshControl)
    }
}