//
//  BaseTableViewCell.swift
//  YouBetMe
//
//  Created by Slava Nechiporenko on 8/10/15.
//  Copyright (c) 2015 Prophonix. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var indexPath : NSIndexPath?
    var containerView = UIView()
    
    static func reuseIdentifier(indexPath : NSIndexPath? = nil) -> String {
        let string = "\(NSStringFromClass(self))ReuseIdentifier"
        if let indexPath = indexPath {
            return string + "\(indexPath.section)\(indexPath.row)"
        }
        return string
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        baseSetUp()
    }
    
    init() {
        super.init(style : .Default, reuseIdentifier : BaseTableViewCell.reuseIdentifier())
        baseSetUp()
    }
    
    private func baseSetUp() {
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        selectionStyle = .None
        
        setUpContainerView()
        setUpDefaults()
        setUpConstraints()
    }
    
    func setUpContainerView() {
        addSubview(containerView)
        
        containerView.autoPinEdgeToSuperviewEdge(.Top)
        containerView.autoPinEdgeToSuperviewEdge(.Left)
        //
        //Pin through apple constraints methods, cause pure layout fails to pin to right and bottom edges of cell on iOS 7
        //
        addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: containerView, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1, constant: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
