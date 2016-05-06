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
    let nameLabel = UILabel()
    private let nameHolderView = UIImageView(image: R.image.bgCellTitle)
    
    override func setUpDefaults() {
        super.setUpDefaults()
        containerView.addSubviews(characterImageView, nameHolderView)
        
        nameHolderView.addSubview(nameLabel)
        nameLabel.textAlignment = .Center
        nameLabel.font = UIFont.boldSystemFontOfSize(15)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .ScaleAspectFill
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        characterImageView.autoPinEdgesToSuperviewEdges()
        nameLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        nameHolderView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30)
        nameHolderView.autoPinEdgeToSuperviewEdge(.Left, withInset: 20)
        nameHolderView.autoSetDimension(.Width, toSize: screenWidth() - 60, relation: .LessThanOrEqual)
    }
}

class CharacterSearchTableViewCell : CharacterTableViewCell {
    override func setUpDefaults() {
        super.setUpDefaults()
        backgroundColor = MDColors.searchCellBackgroundColor()
        
        nameHolderView.image = nil
        
        nameLabel.font = UIFont.systemFontOfSize(18)
        nameLabel.textAlignment = .Left
        nameLabel.textColor = .whiteColor()
    }
    
    override func setUpConstraints() {
        characterImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Right)
        characterImageView.autoMatchDimension(.Width, toDimension: .Height, ofView: characterImageView)
        nameLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        nameHolderView.autoAlignAxisToSuperviewAxis(.Horizontal)
        nameHolderView.autoPinEdge(.Left, toEdge: .Right, ofView: characterImageView)
        nameHolderView.autoPinEdgeToSuperviewEdge(.Right)
    }
}
