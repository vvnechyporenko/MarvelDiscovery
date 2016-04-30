//
//  UIFontSanFrancisco.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/5/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation
import UIKit

enum EnFontType {
    case Bold
    case BoldItalic
    case Heavy
    case HeavyItalic
    case Italic
    case Light
    case LightItalic
    case Medium
    case MediumItalic
    case Regular
    case Semibold
    case SemiboldItalic
    case UltraLight
    case Black
}

extension UIFont {
    static func helveticaFontWithType(type : EnFontType, size : CGFloat) -> UIFont {
        var fontName : String?
        
        switch type {
            
        case .Bold:
            fontName = "HelveticaNeue-Bold"
        case .BoldItalic:
            fontName = "HelveticaNeue-BoldItalic"
        case .Heavy:
            fontName = "HelveticaNeue-CondensedBlack"
        case .Italic:
            fontName = "HelveticaNeue-Italic"
        case .Light:
            fontName = "HelveticaNeue-Light"
        case .LightItalic:
            fontName = "HelveticaNeue-LightItalic"
        case .Medium:
            fontName = "HelveticaNeue-Medium"
        case .MediumItalic:
            fontName = "HelveticaNeue-MediumItalic"
        case .Regular:
            fontName = "HelveticaNeue"
        case .Black:
            fontName = "HelveticaNeue-CondensedBlack"
        default:
            break
        }
        
        if let fontName = fontName {
            if let font = UIFont(name: fontName, size: size) {
                return font
            }
            return UIFont.systemFontOfSize(size)
        }
        
        return UIFont.systemFontOfSize(size)
    }
    
    static func sanFranciscoWithType(type : EnFontType, size : CGFloat) -> UIFont {
        var fontName : String?
        
        switch type {
            
        case .Bold:
            fontName = "SFUIText-Bold"
        case .BoldItalic:
            fontName = "SFUIText-BoldItalic"
        case .Heavy:
            fontName = "SFUIText-Heavy"
        case .HeavyItalic:
            fontName = "SFUIText-HeavyItalic"
        case .Italic:
            fontName = "SFUIText-Italic"
        case .Light:
            fontName = "SFUIText-Light"
        case .LightItalic:
            fontName = "SFUIText-LightItalic"
        case .Medium:
            fontName = "SFUIText-Medium"
        case .MediumItalic:
            fontName = "SFUIText-MediumItalic"
        case .Regular:
            fontName = "SFUIText-Regular"
        case .Semibold:
            fontName = "SFUIText-Semibold"
        case .SemiboldItalic:
            fontName = "SFUIText-SemiboldItalic"
        default:
            break
        }
        
        if let fontName = fontName {
            if let font = UIFont(name: fontName, size: size) {
                return font
            }
            return UIFont.systemFontOfSize(size)
        }
    
        return UIFont.systemFontOfSize(size)
    }
    
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName)
            print("Font Names = [\(names)]")
        }
    }
}