//
//  NetworkManager.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import Foundation

class NetworkManager : AnyObject {
    static let sharedInstance = NetworkManager()
    private let kServerURL = "https://gateway.marvel.com/v1/public/" //
    
    var isInternetReachable : Bool {
        get {
            return reachability!.isReachable()
        }
        set {}
    }
    
    private let reachability = Reachability.reachabilityForInternetConnection()

    
    init() {
        observeInternetConnection()
    }
}

// MARK: Request strings

extension NetworkManager {
    
    ///Sending base request
    func sendRequestWithPath(path : String, method : Method, params : [String : AnyObject]?, completion : ((JSON : JSON?, error : NSError?) -> Void)?) {
        
        if isInternetReachable == false {
            if let completion = completion {
                completion(JSON : nil, error : NSError.errorWithErorType(ErrorCodeType.InternetNotReachable))
            }
            return
        }
        
        var params = params == nil ? [String : AnyObject]() : params!
        
        params["ts"] = String(Int((NSDate().timeIntervalSince1970)))
        params["apikey"] = Constants.ApiPublicKey
        params["hash"] = "\(String(Int((NSDate().timeIntervalSince1970))))\(Constants.ApiPrivateKey)\(Constants.ApiPublicKey)".md5
        
        let requestString = path.hasPrefix("http") ? path : kServerURL + path
        
        request(method, requestString, parameters: params)
        .response { (request, responce, data, error) -> Void in
            
            guard let completion = completion else {
                return
            }
            
            if error != nil {
                errorLog(error!)
                completion(JSON: nil, error: error)
                return
            }
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
            dbgLog(responseString)
            
            guard let data = data else {
                completion(JSON: nil, error: NSError.defaultError())
                return
            }
            
            let json = JSON(data: data)
            if let errorCode = json["code"].int {
                if errorCode != 200 {
                    completion(JSON: json, error: NSError.errorWithErorCode(errorCode))
                }
                else {
                    completion(JSON: json["data"], error: nil)
                }
            }
            completion(JSON: json, error: nil)
        }
    }
}

// MARK: Internet connection observing

extension NetworkManager {
    func observeInternetConnection() {
        reachability!.whenReachable = { reachability in
            if reachability.isReachableViaWiFi() {
                dbgLog("Internet IS Reachable via WiFi")
            } else {
                dbgLog("Internet IS Reachable via Cellular")
            }
        }
        reachability!.whenUnreachable = { reachability in
            dbgLog("Internet IS Not reachable")
            DisplayManager.sharedInstance.navigationController.showError(NSError.errorWithErorType(ErrorCodeType.InternetNotReachable))
        }
        
        reachability!.startNotifier()
    }
}