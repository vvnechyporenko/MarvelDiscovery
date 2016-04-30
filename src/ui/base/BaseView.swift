//
//  BaseView.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import UIKit

class BaseView: UIView {
    init () {
        super.init(frame: CGRectZero)
        translatesAutoresizingMaskIntoConstraints = false
        setUpDefaults()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func statusBarWasTapped() {
    }
}

// MARK: Autolayouted view

extension UIView {
    static func autolayoutView() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setUpDefaults()
        view.setUpConstraints()
        return view
    }
    
    func setUpConstraints() {
        //override in subclasses
    }
    
    func setUpDefaults() {
        //override in subclasses
    }
}
