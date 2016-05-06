//
//  CharacterDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterBaseDetailsTableViewCell: BaseTableViewCell {
    let titleLabel = UILabel()
    let elementsOffset : CGFloat = 12
    
    override func setUpDefaults() {
        super.setUpDefaults()
        addSubview(titleLabel)
        
        titleLabel.textColor = MDColors.redColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(15)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: elementsOffset, left: elementsOffset, bottom: 0, right: elementsOffset), excludingEdge: .Bottom)
    }
    
    func layoutDataView(dataView : UIView) {
        dataView.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: elementsOffset)
        dataView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: elementsOffset, bottom: elementsOffset, right: elementsOffset), excludingEdge: .Top)
    }
}
