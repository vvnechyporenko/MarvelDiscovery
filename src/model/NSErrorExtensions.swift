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
    case UnknownError = 500
    case Unauthorized = 409
    case NotFound     = 404
    case InternetNotReachable = 999
}

extension NSError {
    static func errorWithErorType(errorType : ErrorCodeType?) -> NSError {
        let type = errorType == nil ? .UnknownError : errorType
        return NSError(domain: kEnErrorDomain, code: type!.rawValue, userInfo: [NSLocalizedDescriptionKey : errorDescriptionWithType(errorType!)])
    }
    
    static func defaultError() -> NSError {
        return errorWithErorType(.UnknownError)
    }
    
    static func errorWithErorCode(errorCode : Int?) -> NSError {
        let code = errorCode == nil ? ErrorCodeType.UnknownError.rawValue : errorCode
        return errorWithErorType(ErrorCodeType(rawValue: code!))
    }
    
    static func errorWithDescription(errorDescription : String) -> NSError {
        return NSError(domain: kEnErrorDomain, code: kEnEmptyErorCode, userInfo: [NSLocalizedDescriptionKey : errorDescription])
    }

    static func errorDescriptionWithType(type : ErrorCodeType) -> String {
        var errorDescription = "Sorry, but something went wrong".localized()
        
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