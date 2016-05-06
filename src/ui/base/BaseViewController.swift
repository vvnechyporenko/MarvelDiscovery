//
//  BaseViewController.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 8/4/15.
//  Copyright (c) 2015 Nominanza. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation
import Photos

protocol KeyboardChangesProtocol {
    func keyboardWillShowWithSize(keyboardSize : CGSize)
    func keyboardWillHide()
}

class BaseViewController: UIViewController {
    
    var keyboardIsShown = false //Works only if startObservingKeyboardChanges was called
    var currentKeyboardHeight : CGFloat = 0
    var isFirstAppearing = true
    
    override func loadView() {
        super.loadView()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.hidesBackButton = true
        NSNotificationCenter.defaultCenter().addObserverForName(kStatusBarTappedNotification, object: nil, queue: NSOperationQueue.mainQueue()) {[weak self] (notification) -> Void in
            self?.statusBarWasTapped()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kStatusBarTappedNotification, object: nil)
    }

    func layoutContentView(contentView : UIView) {
        view.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        isFirstAppearing = false
    }
    
    func isRootViewController() -> Bool {
        if let navigationController = navigationController {
            return navigationController.viewControllers.count == 1
        }
        return false
    }
}

// MARK: Status bar touch

extension BaseViewController {
    func statusBarWasTapped() {
        for subview in view.subviews {
            if subview.respondsToSelector(#selector(BaseViewController.statusBarWasTapped)) {
                subview.performSelector(#selector(BaseViewController.statusBarWasTapped))
            }
        }
    }
}

// MARK: Keyboard observing

extension BaseViewController : KeyboardChangesProtocol {
    func startObservingKeyboardChanges() {

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note : NSNotification) -> Void in
            
            if let userInfo = note.userInfo {
                if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                    if self.keyboardIsShown == false || self.currentKeyboardHeight != keyboardSize.height {
                        self.keyboardIsShown = true
                        self.currentKeyboardHeight = keyboardSize.height
                        self.keyboardWillShowWithSize(keyboardSize.size)
                    }
                }
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note : NSNotification) -> Void in
            if self.keyboardIsShown == true {
                self.keyboardIsShown = false
                self.keyboardWillHide()
            }
        }
    }
    
    func endObservingKeyboardChanges() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowWithSize(keyboardSize : CGSize) {
        //Override in inherited classes
    }
    
    func keyboardWillHide() {
        //Override in inherited classes
    }
}

// MARK: Actions

extension BaseViewController {
    func navigateBack() {
        navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: Images management

extension BaseViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImageSourceChooser() {
        
        let actionSheet = UIAlertController(title: "CHOOSE IMAGE SOURCE".localized(), message: "", preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Gallery".localized(), style: UIAlertActionStyle.Default, handler: {[weak self] (alertAction) -> Void in
            self?.showImagePickerWithSourceType(.PhotoLibrary)
            }))
        actionSheet.addAction(UIAlertAction(title: "Camera".localized(), style: UIAlertActionStyle.Default, handler: {[weak self] (alertAction) -> Void in
            self?.showImagePickerWithSourceType(.Camera)
            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized(), style: .Cancel, handler: {[weak self] (alertAction) -> Void in
            self?.dismissViewControllerAnimated(true, completion: nil)
            }))
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showImagePickerWithSourceType(sourceType : UIImagePickerControllerSourceType) {
        
        checkAccessToImageSourcheType(sourceType) {[weak self] (accessGranted) -> Void in
            gcd.async(QueueType.Main, closure: { () -> () in
                if accessGranted == true {
                    let picker = UIImagePickerController()
                    picker.sourceType = sourceType
                    picker.delegate = self
                    picker.allowsEditing = true
                    UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
                    self?.presentViewController(picker, animated: true, completion: nil)
                }
                else {
                    self?.showAccessErrorWithType(sourceType)
                }
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        })
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imagePickerDidFinishWithImage(imageWithNormalizedOrientation(image))
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        })
    }
    
    func imagePickerDidFinishWithImage(image : UIImage) { }
    
    //MARK: private
    
    private func checkAccessToImageSourcheType(sourceType : UIImagePickerControllerSourceType, completion: (Bool) -> Void) {
        
        if sourceType == .PhotoLibrary {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .Authorized {
                completion(true)
            }
            else if status == .Denied || status == .Restricted {
                completion(false)
            }
            else if status == .NotDetermined {
                PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                    completion(status == .Authorized)
                })
            }
        }
        else if sourceType == .Camera {
            let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
            if status == .Authorized {
                completion(true)
            }
            else if status == .Denied || status == .Restricted {
                completion(false)
            }
            else if status == .NotDetermined {
                AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) -> Void in
                    completion(granted)
                })
            }
        }
    }
    
    private func showAccessErrorWithType(sourceType : UIImagePickerControllerSourceType) {
        let typeString = sourceType == .Camera ? "Camera" : "Gallery"
        let allowString = "You should allow access to your".localized()
        showAlertWithTitle("Error".localized(), message: "\(allowString) \(typeString)")
        
    }
    
    private func imageWithNormalizedOrientation(image : UIImage) -> UIImage {
        if image.imageOrientation == .Up {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.drawInRect(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}