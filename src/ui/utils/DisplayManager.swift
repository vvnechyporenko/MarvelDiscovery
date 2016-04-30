//
//  DisplayManager.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import SafariServices

let kButtonHeight :CGFloat = 36

//Custom error
@available(iOS, deprecated=1.0, message="***FIXME***") func FIXME(log : String? = nil) {
    if let log = log {
        dbgLog(log)
    }
}

// MARK: System function

func statusBarHeight() -> CGFloat {
    return UIApplication.sharedApplication().statusBarFrame.size.height
}

func screenHeight() -> CGFloat {
    return UIScreen.mainScreen().bounds.size.height
}

func screenWidth() -> CGFloat {
    return UIScreen.mainScreen().bounds.size.width
}

func downScaleFactor() -> CGFloat {
    return runningOnIPhone6Plus() ? 1.15 : 1
}

func isIOS8OrGreater() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0
}

func runningOnSmallIPhone() -> Bool {
    return screenHeight() == 480
}

func runningOnIPhone5() -> Bool {
    return screenHeight() == 568
}

func runningOnIPhone6() -> Bool {
    return screenHeight() == 667
}

func runningOnIPhone6Plus() -> Bool {
    return screenHeight() == 736
}

func navigationBarHeight() -> CGFloat {
    return UIApplication.sharedApplication().statusBarFrame.height + 44
}

func runningOnNarrowScreen() -> Bool {
    return screenWidth() < 375
}

func runningOnSimulator() -> Bool {
    return TARGET_OS_SIMULATOR != 0
}


let kStatusBarTappedNotification = "kStatusBarTappedNotification"

// MARK: Log

func dbgLog(logMessage: String?, functionName: String = #function, className: String = #file) {
    if runningInDebugMode() == true {
        guard let logMessage = logMessage else { return }
        
        let shortClassName = className.componentsSeparatedByString("/").last!
        
        let timeNow = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .LongStyle)
        print("[\(timeNow)] \(shortClassName) \(functionName): \(logMessage)")
    }
}

func errorLog(error : NSError, functionName: String = #function, className: String = #file) {
    let errorString = "Failed with error: \(error.code) \(error.userInfo)"
    dbgLog(errorString, functionName : functionName, className : className)
}

// MARK: General

class DisplayManager : AnyObject {
    static let sharedInstance = DisplayManager()
    
    let dateFormatter = NSDateFormatter()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var navigationController = BaseNavigationController(rootViewController: CharactersListViewController())
    
    var currentViewController : BaseViewController? {
        return navigationController.viewControllers.last as? BaseViewController
    }
    
    func setUpDefaults() {
        //Main window
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.rootViewController = navigationController

        //Time formatter
        dateFormatter.timeZone   = NSTimeZone.localTimeZone()
        dateFormatter.locale     = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
    }
}

// MARK: Web content

extension DisplayManager {
    func showWebPageWithString(string : String?) {
        guard let string = string else {
            return
        }
        showWebPageWithUrl(NSURL(string : string))
    }
    
    func showWebPageWithUrl(urlString : NSURL?) {
        guard let urlString = urlString else {
            return
        }
        
        if #available(iOS 9.0, *) {
            
            let svc = SFSafariViewController(URL: urlString)
            
            let navVC = UINavigationController(rootViewController: svc)
            navVC.navigationBarHidden = true
            
            navigationController.presentViewController(navVC, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(urlString)
        }
    }
}