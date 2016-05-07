//
//  ItemCoverView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/8/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class ItemCoverView: BaseView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        addSubviews(imageView, titleLabel)
        
        imageView.contentMode = .ScaleAspectFill
        imageView.backgroundColor = MDColors.searchCellBackgroundColor()
        imageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = .whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 2
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0))
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right)
        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView, withOffset: 22)
    }
}
