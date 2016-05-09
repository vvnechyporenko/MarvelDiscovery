//
//  AppDelegate.swift
//  RSSSpeaker
//
//  Created by winmons on 3/22/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //To save time - disable animations for testing
        if NSProcessInfo.processInfo().environment["animations"] == "0" {
            UIView.setAnimationsEnabled(false)
        }
        
        //set up business logic defaults
        DataManager.sharedInstance
        
        //set up window
        DisplayManager.sharedInstance.setUpDefaults()
        
        return true
    }
}

