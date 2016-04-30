//
//  BaseImageView.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/12/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import UIKit

class BaseImageView: UIImageView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }

    @IBInspectable var shouldBeCircle : Bool = false {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var shouldShowActivityIndicator = true {
        didSet {
            setShowActivityIndicatorView(shouldShowActivityIndicator)
            if shouldShowActivityIndicator == true {
                setIndicatorStyle(.White)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shouldBeCircle == true {
            roundCorner(frame.size.width / 2)
        }
        else {
            layer.cornerRadius = 0
        }
    }
}

// MARK: Setting image with paths/urls

extension UIImageView {
    func setImageWithUrlPath(path : String?) {
        setImageWithUrlPath(path, placeholderImage : nil)
    }
    
    func setImageWithUrlPath(path : String?, placeholderImage : UIImage?) {
        setImageWithUrlPath(path, placeholderImage: placeholderImage, completed: nil)
    }
    
    func setImageWithUrlPath(path : String?, placeholderImage : UIImage?, completed : ((downloadedImage : UIImage?, error : NSError?) -> Void)?) {
        if let path = path {
            
            if let pathIm = UIImage(named: path) {
                image = pathIm
            }
            else if path.containsString("http") == false {
                image = UIImage(named: path)
            }
            else {
                
                if self.isKindOfClass(BaseImageView.classForCoder()) {
                    (self as! BaseImageView).shouldShowActivityIndicator = (self as! BaseImageView).shouldShowActivityIndicator == true ? true : false
                }
                
                if let urlPath = NSURL(string: path) {
                    sd_setImageWithURL(urlPath, placeholderImage: placeholderImage, completed: { (image, error, _, url) -> Void in
                        if let completed = completed {
                            completed(downloadedImage: image, error: error)
                        }
                    })                }
            }
        }
        else {
            image = placeholderImage
        }
    }
}
