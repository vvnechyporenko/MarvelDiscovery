//
//  CharacterImageDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterImageDetailsTableViewCell: CharacterBaseDetailsTableViewCell {
    let characterImageView = BaseImageView()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        
        titleLabel.hidden = true
        containerView.addSubview(characterImageView)
        characterImageView.contentMode = .ScaleAspectFill
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        characterImageView.autoPinEdgesToSuperviewEdges()
        characterImageView.autoSetDimension(.Height, toSize: 335)
    }
}
