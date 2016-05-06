//
//  CharacterTextDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterTextDetailsTableViewCell: CharacterBaseDetailsTableViewCell {
    let infoLabel = UILabel()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        
        containerView.addSubview(infoLabel)
        infoLabel.textColor = .whiteColor()
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFontOfSize(18)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        layoutDataView(infoLabel)
    }
}
