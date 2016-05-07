//
//  ContentsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
    let contentImageView = BaseImageView()
    let contentNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clearColor()
        contentView.addSubviews(contentImageView, contentNameLabel)
        
        contentImageView.contentMode = .ScaleAspectFill
        contentImageView.backgroundColor = MDColors.searchCellBackgroundColor()
        contentImageView.clipsToBounds = true
        
        contentNameLabel.textColor = .whiteColor()
        contentNameLabel.textAlignment = .Center
        contentNameLabel.font = UIFont.systemFontOfSize(13)
        contentNameLabel.numberOfLines = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentImageView.frame = CGRect(x: 0, y: 0, width: frame.size.height - 10, height: frame.size.width - 65)
        contentNameLabel.frame = CGRect(x: 0, y: frame.size.width - 65, width: frame.size.height - 10, height: 55)
    }
}
