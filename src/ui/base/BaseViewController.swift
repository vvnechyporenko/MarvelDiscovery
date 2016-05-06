//
//  BaseViewController.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation
import Photos

protocol KeyboardChangesProtocol {
    func keyboardWillShowWithSize(keyboardSize : CGSize)
    func keyboardWillHide()
}

class BaseViewController: UIViewController {
    
    var keyboardIsShown = false //Works only if startObservingKeyboardChanges was called
    var currentKeyboardHeight : CGFloat = 0
    var isFirstAppearing = true
    
    override func loadView() {
        super.loadView()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.hidesBackButton = true
        NSNotificationCenter.defaultCenter().addObserverForName(kStatusBarTappedNotification, object: nil, queue: NSOperationQueue.mainQueue()) {[weak self] (notification) -> Void in
            self?.statusBarWasTapped()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kStatusBarTappedNotification, object: nil)
    }

    func layoutContentView(contentView : UIView) {
        view.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        isFirstAppearing = false
    }
    
    func isRootViewController() -> Bool {
        if let navigationController = navigationController {
            return navigationController.viewControllers.count == 1
        }
        return false
    }
}

// MARK: Status bar touch

extension BaseViewController {
    func statusBarWasTapped() {
        for subview in view.subviews {
            if subview.respondsToSelector(#selector(BaseViewController.statusBarWasTapped)) {
                subview.performSelector(#selector(BaseViewController.statusBarWasTapped))
            }
        }
    }
}

// MARK: Keyboard observing

extension BaseViewController : KeyboardChangesProtocol {
    func startObservingKeyboardChanges() {

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note : NSNotification) -> Void in
            
            if let userInfo = note.userInfo {
                if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                    if self.keyboardIsShown == false || self.currentKeyboardHeight != keyboardSize.height {
                        self.keyboardIsShown = true
                        self.currentKeyboardHeight = keyboardSize.height
                        self.keyboardWillShowWithSize(keyboardSize.size)
                    }
                }
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note : NSNotification) -> Void in
            if self.keyboardIsShown == true {
                self.keyboardIsShown = false
                self.keyboardWillHide()
            }
        }
    }
    
    func endObservingKeyboardChanges() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowWithSize(keyboardSize : CGSize) {
        //Override in inherited classes
    }
    
    func keyboardWillHide() {
        //Override in inherited classes
    }
}

// MARK: Actions

extension BaseViewController {
    func navigateBack() {
        navigationController?.popViewControllerAnimated(true)
    }
}