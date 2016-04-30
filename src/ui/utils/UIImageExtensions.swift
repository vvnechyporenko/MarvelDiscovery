//
//  UIImageExtensions.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/5/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func imageForCurrentDeviceWithName(name : String) -> UIImage? {
        if UIScreen.mainScreen().bounds.size.height == 568 {
            let deviceName = "\(name)568h"
            if let image = UIImage(named: deviceName)
            {
                return image
            }
            else if let image = UIImage(named: "\(deviceName).jpg") {
                return image
            }
        }
        else if UIScreen.mainScreen().bounds.size.height == 667 {
            let deviceName = "\(name)667h"
            if let image = UIImage(named: deviceName)
            {
                return image
            }
            else if let image = UIImage(named: "\(deviceName).jpg") {
                return image
            }
        }
        
        if let image = UIImage(named: name)
        {
            return image
        }
        
        return UIImage(named: "\(name).jpg")
    }
    
    func toSize(targetSize : CGSize) -> UIImage {
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
