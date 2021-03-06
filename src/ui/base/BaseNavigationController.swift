//
//  BaseNavigationController.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/6/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    var swipeBackGesture : UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    func swipeBackGestureRecognized() {
        if viewControllers[0] != topViewController {
            popViewControllerAnimated(true)
        }
    }
}

// MARK: Navigation bar customization

extension UINavigationBar {
    func makeTransparent() {
        setBackgroundImage(UIImage(), forBarMetrics: .Default)
        translucent = true
        shadowImage = UIImage()
    }
}
