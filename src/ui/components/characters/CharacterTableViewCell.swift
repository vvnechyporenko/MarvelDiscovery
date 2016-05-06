//
//  CharacterTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterTableViewCell: BaseTableViewCell {
    let characterImageView = BaseImageView()
    
    override func setUpDefaults() {
        super.setUpDefaults()
        containerView.addSubview(characterImageView)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        characterImageView.autoPinEdgesToSuperviewEdges()
    }
}
