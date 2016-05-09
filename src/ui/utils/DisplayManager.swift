//
//  DisplayManager.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import SafariServices

// MARK: General

class DisplayManager : AnyObject {
    static let sharedInstance = DisplayManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var navigationController = UINavigationController(rootViewController: CharactersListViewController())
    
    var currentViewController : BaseViewController? {
        return navigationController.viewControllers.last as? BaseViewController
    }
    
    func setUpDefaults() {
        //Main window
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.rootViewController = navigationController
    }
}

// MARK: Display content

extension DisplayManager {
    func showCharacterDetailsWithCharacter(character : Character) {
        let detailsController = CharacterDetailsViewController()
        detailsController.character = character
        navigationController.pushViewController(detailsController, animated: true)
    }
    
    func showContentSummaryInArray(array : [ContentSummary], forIndex index : Int) {
        let itemsController = ItemsSummaryViewController()
        itemsController.summaryArray = array
        itemsController.currentIndex = index
        navigationController.presentpopupViewController(itemsController, animationType: SLpopupViewAnimationType.Fade) { }
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