//
//  NSErrorExtensions.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/6/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation

let kEnErrorDomain = "com.prophonix.ENlive"
let kEnLoginErrorDomain = "com.prophonix.ENlive.login"
let kEnEmptyErorCode = 0

//errors 600-610 - Authorization errors

enum ErrorCodeType : Int {
    case Facebook = -2
    case VKError = -1
    case Cancel = -3
    case LoginFormatIncorrect = 1
    case StatisticsLocked = 20
    case PasswordFormatIncorrect = 105
    case EmailFormatIncorrect = 3
    case DomenFormatIncorrect = 10
    case DomenEmpty = 11
    case Passwordempty = 4
    case Emailempty = 5
    case FacebookLoginCanceled = 6
    case PasswordsNotIdentical = 7
    case NoUserWithIDFound = 404
    case UserIsNotFriend = 435
    case FriendRequestAlreadySend = 433
    case EmailOccupied = 104
    case UnknownError = 500
    case InvalidEmailPassword = 107
    case OldPasswordIncorrect = 403
    case Unauthorized = 401
    case DeviceTokenAlreadyRegistered = 409
    case UserDeviceNotConnected = 424
    case InternetNotReachable = 999
    
    case AuthSuccess = 600
    case AuthAttemptsOverflow = 601
    case AuthIncorrectLoginPassword = 602
    case AuthBlackList = 603
    case AuthIpBlock = 604
    case AuthServerError = 605
    case AuthJsonError = 606
    case AuthUserAdminBlocked = 607
    case AuthNewuserNotActivated = 608
    case AuthBruteForce = 609
    case AuthEmailNotConfirmed = 610
}

extension NSError {
    static func errorWithErorType(errorType : ErrorCodeType?) -> NSError {
        let type = errorType == nil ? .UnknownError : errorType
        return NSError(domain: kEnErrorDomain, code: type!.rawValue, userInfo: [NSLocalizedDescriptionKey : errorDescriptionWithType(errorType!)])
    }
    
    static func errorWithErorCode(errorCode : Int?) -> NSError {
        let code = errorCode == nil ? ErrorCodeType.UnknownError.rawValue : errorCode
        return errorWithErorType(ErrorCodeType(rawValue: code!))
    }
    
    static func errorWithDescription(errorDescription : String) -> NSError {
        return NSError(domain: kEnErrorDomain, code: kEnEmptyErorCode, userInfo: [NSLocalizedDescriptionKey : errorDescription])
    }

    static func errorDescriptionWithType(type : ErrorCodeType) -> String {
        var errorDescription = "Извините, но что-то пошло не по правилам.."
        
        switch type {
        case .UnknownError  :
            errorDescription = "Sorry, but something went wrong".localized()
        case .InternetNotReachable:
            errorDescription = "Internet connection is missing".localized()
        default : break
        }
        
        return errorDescription
    }
    
    static func errorWithDomain(domain : String, code : Int) -> NSError? {
        
        let errorCode = code
        
        if let errorType = ErrorCodeType(rawValue: errorCode) {
            return NSError(domain: domain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey : errorDescriptionWithType(errorType)])
        }
        
        return nil
    }
}

// MARK: String Validation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func isEmpty() -> Bool {
        if length == 0 {
            return true
        }
        
        if (self as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
            return true
        }
        
        return false
    }
}