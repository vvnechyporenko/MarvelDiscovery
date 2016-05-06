//
//  ContentsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class ContentsTableViewCell: BaseTableViewCell {
    let contentImageView = BaseImageView()
    let contentNameLabel = UILabel()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        containerView.addSubviews(contentImageView, contentNameLabel)
        
        contentImageView.contentMode = .ScaleAspectFill
        
        contentNameLabel.textColor = .whiteColor()
        contentNameLabel.textAlignment = .Center
        contentNameLabel.font = UIFont.systemFontOfSize(15)
    }
}
