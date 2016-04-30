//
//  UIViewControllerExtension.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import UIKit

// MARK: Alert extension
extension UIViewController {
    
    func showAlertWithTitle(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showErrorWithMessage(message : String) {
        showAlertWithTitle("Ошибка".localized(), message : message)
    }
    
    func showError(error : NSError) {
        if error.code != ErrorCodeType.FacebookLoginCanceled.rawValue && error.code != ErrorCodeType.Cancel.rawValue {
            showAlertWithTitle("Ошибка".localized(), message : error.localizedDescription)
        }
    }
    
    func removeAllObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

let kActivityIndicatorTag = 1001

// MARK: ActivityIndicator extension

extension UIViewController {
    func showActivityIndicator() {
        gcd.async(.Main, closure: {[weak self] () -> () in
            let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
            hud.tag = kActivityIndicatorTag
            hud.showInView(self?.view, animated: true)
        })
    }
    
    func hideActivityIndicator() {
        gcd.async(.Main, closure: {[weak self] () -> () in
            if let hud = self?.view.viewWithTag(kActivityIndicatorTag) as? JGProgressHUD {
                hud.dismissAnimated(true)
            }
        })
    }
}

// MARK: image share

extension UIViewController {
    func shareImage(image : UIImage) {
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}

