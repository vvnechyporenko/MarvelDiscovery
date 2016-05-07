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
    var constraintTopImageView : NSLayoutConstraint?
    
    override func setUpDefaults() {
        super.setUpDefaults()
        clipsToBounds = false
        titleLabel.hidden = true
        containerView.addSubview(characterImageView)
        characterImageView.contentMode = .ScaleAspectFill
        characterImageView.clipsToBounds = true
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        characterImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
        constraintTopImageView = characterImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 0, relation: .Equal)
        containerView.autoSetDimension(.Height, toSize: 335)
    }
}
