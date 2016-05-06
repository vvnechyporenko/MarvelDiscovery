//
//  UIColorExtensions.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/5/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import UIKit

// MARK: Colors not deviding 255

extension UIColor {
    static func normalizedColorWithRed(red : CGFloat, green : CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
    
    static func normalizedColorWithWhite(white : CGFloat) -> UIColor {
        return UIColor(white: white/255.0, alpha: 1)
    }
}

// MARK: Application colors

class MDColors : AnyObject {
    static func blackColor() -> UIColor {
        return UIColor.normalizedColorWithRed(12, green: 14, blue: 15)
    }
    
    static func charactersListBackgroundColor() -> UIColor {
        return UIColor.normalizedColorWithRed(40, green: 44, blue: 48)
    }
    
    static func redColor() -> UIColor {
        return UIColor.normalizedColorWithRed(241, green: 24, blue: 45)
    }
    
    static func searchCellBackgroundColor() -> UIColor {
        return UIColor.normalizedColorWithRed(60, green: 63, blue: 67)
    }
    
    static func cellSeparatorColor() -> UIColor {
        return UIColor.normalizedColorWithRed(71, green: 72, blue: 73)
    }
}

// MARK: hash

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

// MARK: manipulations

extension UIColor {
    func toImage() -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}