//
//  CharacterDetailsTableViewCell.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterDetailsTableViewCell: BaseTableViewCell {
    let titleLabel = UILabel()
    
    override func setUpDefaults() {
        super.setUpDefaults()
//        addSubviews(titleLabel, dataView())
        titleLabel.textColor = MDColors.redColor()
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), excludingEdge: .Bottom)
        
    }
    
    static func dataViews() -> UIView {
        fatalError("Override in subclasses, do not use as it is")
        return UIView()
    }
}
