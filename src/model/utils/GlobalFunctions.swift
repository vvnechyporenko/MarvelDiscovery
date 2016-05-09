//
//  GlobalFunctions.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/9/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import Foundation

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