//
//  DataManager.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import AVFoundation

func runningInDebugMode() -> Bool {
    return NSProcessInfo.processInfo().environment["runningDebug"] != nil
}

class DataManager: AnyObject {
    
    init() {
        setUpDefaults()
    }
    
    static let sharedInstance = DataManager()
    
    func setUpDefaults() {
        setupDB()
        
        NetworkManager.sharedInstance
    }
}

//MARK: database management

extension DataManager {
    
    func setupDB() {
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed(self.dbStore())
    }
    
    func dbStore() -> String {
        return "MarvelDiscovery"
    }
    
    func bundleID() -> String {
        return NSBundle.mainBundle().bundleIdentifier!
    }
    
    func saveData(completion : ((Bool)->())? = nil) {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (completed, error) -> Void in
            if let err = error {
                errorLog(err)
            }
            
            if completion != nil {
                completion!(completed)
            }
        }
    }
    
    func cleanAndResetupDB() {
        saveData(nil)
    }
}