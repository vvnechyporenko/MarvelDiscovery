//
//  Extensions.swift
//  AirKiss
//
//  Created by Slava Nechiporenko on 10/4/15.
//  Copyright © 2015 Nominanza. All rights reserved.
//

import Foundation

// MARK: String extension

let kLongtitudeRegexString = "^\\s*[-+]?([Nn]*)(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)(°*)$"
let kLatitudeRegesString   = "^[-+]?([Ee]*)([1-8]?\\d(\\.\\d+)?|90(\\.0+)?)(°*)$"
let kLocationCoordinatesRegex = "(\(kLongtitudeRegexString))(,*)(\(kLatitudeRegesString))"

extension String {
    
    var length : Int {
        return characters.count
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
    func trimSpaces() -> String {
        return (self as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func matchRegexString(regexString : String) -> Bool {
        let longtitudeTest = NSPredicate(format:"SELF MATCHES %@", regexString)
        return longtitudeTest.evaluateWithObject(self)
    }
    
    func rangesOfOccurencesByRegexString(regString : String) -> [NSRange] {
        do {
            let regex = try NSRegularExpression(pattern: regString, options: [])
            let results = regex.matchesInString(self,
                options: [], range: NSMakeRange(0, length))
            return results.map { $0.range}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func isEnglishLanguage() -> Bool {
        return matchRegexString("[a-zA-Z\\s]+")
    }
    
    func urlEncodeString() -> String {
        if let encodedString = stringByReplacingOccurrencesOfString(" ", withString: " ").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            return encodedString
        }
        return self
    }
    
    func trimHTMLTags() -> String {
        return stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
    }
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    func removeCharacterAtPosition(position : Int) -> String {
        if length >= position {
            if position > 0 {
                return String(self.characters.prefix(position-1)) + String(self.characters.suffix(self.characters.count-position))
            }
            if position == 0 {
                return String(self.characters.suffix(self.characters.count-(position+1)))
            }
        }
        return self
    }
    
    func stringByReplacingOccurancesOfStrings(stringsArray : [String], byString : String) -> String {
        var mutableString = self
        
        for stringToReplace in stringsArray {
            mutableString = mutableString.stringByReplacingOccurrencesOfString(stringToReplace, withString: byString)
        }
        
        return mutableString
    }
    
    func containsOneOfStrings(stringsArray : [String]) -> Bool {
        for string in stringsArray {
            if containsString(string) == true {
                return true
            }
        }
        
        return false
    }
    
    func hasOneOfPrefixes(stringsArray : [String]) -> Bool {
        for string in stringsArray {
            if hasPrefix(string) == true {
                return true
            }
        }
        
        return false
    }
    
    func startsWithNumber() -> Bool {
        guard let firstWord = componentsSeparatedByCharactersInSet(NSCharacterSet.punctuationCharacterSet()).first?.componentsSeparatedByString(" ").first else {
            return false
        }
        
        guard let number = Int(firstWord) else {
            return false
        }
        
        return number > 0 && number < 51
    }
}

// MARK: DateTime

extension NSDate {
    func weekDayAndTimeOfDay() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        var returnString = dateFormatter.stringFromDate(self)
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour], fromDate: self)
        let hour = comp.hour
        
        returnString += " "

        if hour < 11 && hour >= 4 {
            returnString += "Morning"
        }
        else if hour < 16 && hour >= 11 {
            returnString += "Afternoon"
        }
        else if hour < 20 && hour >= 16 {
            returnString += "Evening"
        }
        else {
            returnString += "Night"
        }
        
        return returnString
    }
}

// MARK: Array remove method

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

// MARK: random number

extension Int {
    static func randomNumberInBounds(bounds : Int) -> Int {
        return Int(arc4random_uniform(UInt32(bounds)))
    }
}

// MARK: Gesture recognizer

extension UIGestureRecognizer {
    func stop() {
        enabled = false
        enabled = true
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

// MARK: letters spacint

extension String {
    func doubleSpacedString() -> String {
        
        var spaced = ""
        
        for letter in characters {
            spaced += String(letter) + " "
        }
        
        
        return spaced
    }
}

// MARK: Layout

extension UIView {
    func autoPinEdgesToEdgesOfView(view : UIView, offset : CGFloat = 0) {
        autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -offset)
        autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: offset)
        autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: -offset)
        autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view, withOffset: offset)
    }
    
    func autoPinViewsEdgesToSuperview(views : [UIView], edges : [ALEdge], inset : CGFloat = 0, relationship : NSLayoutRelation = NSLayoutRelation.Equal) -> [NSLayoutConstraint] {
        
        var constraintsArray = [NSLayoutConstraint]()
        
        for view in views {
            for edge in edges {
                constraintsArray.append(view.autoPinEdgeToSuperviewEdge(edge, withInset: inset, relation: relationship))
            }
        }
        
        return constraintsArray
    }
    
    func autoDiscributeViews(views : [UIView], alongAxis : ALAxis, offset : CGFloat, relationship : NSLayoutRelation = NSLayoutRelation.Equal)  -> [NSLayoutConstraint] {
        var lastView : UIView?
        var constraintsArray = [NSLayoutConstraint]()
        
        for view in views {
            if lastView != nil {
                let viewToPin = lastView == nil ? view.superview! : lastView!
                constraintsArray.append(view.autoPinEdge(alongAxis == .Vertical ? .Top : .Left, toEdge: alongAxis == .Vertical ? .Bottom : .Right, ofView: viewToPin, withOffset: offset, relation: relationship))
            }
            
            lastView = view
        }
        
        return constraintsArray
    }
    
    func autoMatchDimensionOfViews(views : [UIView], toSuperviewDimension dimension : ALDimension)  -> [NSLayoutConstraint] {
        var constraintsArray = [NSLayoutConstraint]()
        
        for view in views {
            constraintsArray.append(view.autoMatchDimension(dimension, toDimension: dimension, ofView: view.superview!))
        }
        
        return constraintsArray
    }
    
    func autoMatchDimensionOfViews(views : [UIView], dimension : ALDimension, toSuperviewDimension superviewDimension : ALDimension)  -> [NSLayoutConstraint] {
        var constraintsArray = [NSLayoutConstraint]()
        
        for view in views {
            constraintsArray.append(view.autoMatchDimension(dimension, toDimension: superviewDimension, ofView: view.superview!))
        }
        
        return constraintsArray
    }
    
    func animateSetNeedsLayout(duration : CGFloat = 0.33) {
        UIView.animateWithDuration(0.33) { () -> Void in
            self.layoutIfNeeded()
        }
    }
}

// MARK: ScrollView contentSize

extension UIScrollView {
    func fillDimensionsContentSize() {
        let view = UIView()
        insertSubview(view, atIndex: 0)
        view.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        view.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        view.autoPinEdgesToSuperviewEdges()
    }
    
    var isScrolling : Bool {
        return layer.animationForKey("bounds") != nil;
    }
}

// MARK: UISwitch

extension UISwitch {
    func toogleState() {
        gcd.delay(0.1) { () -> () in
            self.on = !self.on
        }
    }
}

// MARK: Degrees

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

// MARK: Initializers

extension UIButton {
    convenience init(image : UIImage?) {
        self.init()
        setImage(image, forState: .Normal)
    }
}

extension UIView {
    convenience init(color : UIColor) {
        self.init()
        backgroundColor = color
    }
}

extension UILabel {
    convenience init(labelText : String?) {
        self.init()
        text = labelText
    }
}

// MARK: Refresh control

extension UIScrollView {
    var refreshControl : UIRefreshControl? {
        for subview in subviews {
            if subview.isKindOfClass(UIRefreshControl.classForCoder()) {
                return subview as? UIRefreshControl
            }
        }
        return nil
    }
}

// MARK: Kernel label

extension UILabel {
    func setKernelText(string : String) {
        let kernel = 2
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSKernAttributeName, value: kernel, range: NSRange(location: 0, length: string.length))
        attributedText = attributedString
    }
}

// MARK: Bunle

extension NSBundle {
    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
}

// MARK: Screenshot

extension UIView {
    func convertViewToImage() -> UIImage{
        UIGraphicsBeginImageContext(self.bounds.size);
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image;
    }
}

// MARK: Scroll to top

extension UIScrollView {
    func scrollToTop() {
        scrollToTop(true)
    }
    
    func scrollToTop(animated : Bool) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}

extension BaseView {
    func scrollToTop() {
        //override in subclasses if needed
    }
}

// MARK: Subviews

extension UIView {
    func addSubviews(views: UIView...) {
        for view:UIView in views {
            
            self.addSubview(view)
        }
    }
    
    func addSubviews(views: [UIView]) {
        for view:UIView in views {
            self.addSubview(view)
        }
    }
    
    func roundCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundToCircle() {
        roundCorner(frame.size.width / 2)
    }
    
    func removeAllSubviews() {
        for subview:UIView in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func removeAllConstraints() {
        removeConstraints(constraints)
    }
}

// MARK: Force touch capability

extension UIView {
    var forceTouchAvailable : Bool {
        if #available(iOS 9.0, *) {
            return traitCollection.forceTouchCapability == .Available
        } else {
            return false
        }
    }
}

// MARK: ActivityIndicator extension

extension UIView {
    func showActivityIndicator() {
        gcd.async(.Main, closure: {[weak self] () -> () in
            let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
            hud.tag = kActivityIndicatorTag
            hud.showInView(self, animated: true)
            })
    }
    
    func hideActivityIndicator() {
        gcd.async(.Main, closure: {[weak self] () -> () in
            if let hud = self?.viewWithTag(kActivityIndicatorTag) as? JGProgressHUD {
                hud.dismissAnimated(true)
            }
            })
    }
}

// MARK: Screenshot

extension UIView {
    func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, self.opaque, 0.0)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIScrollView {
    override func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(contentSize, self.opaque, 0.0)
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        contentOffset = CGPointZero
        frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        contentOffset = savedContentOffset
        frame = savedFrame
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

// MD5

extension String  {
    var md5: String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}

// MARK: Date extension

extension NSDate {
    func displayString() -> String {
        let stringDate = DisplayManager.sharedInstance.dateFormatter.stringFromDate(self)
        var components = stringDate.componentsSeparatedByString(" ")
        
        var day = components[2]
        if String(Array(day.characters)[0]) == "0" {
            day = String(day.characters.dropFirst())
        }
        
        var time = components[3]
        if String(Array(time.characters)[0]) == "0" {
            time = String(time.characters.dropFirst())
        }
        
        let dayTH = "\(day)\(daySuffix(self)),"
        let outputString = "\(components[0]) \(components[1]) \(dayTH) \(time) \(components[4])"
        
        return outputString.uppercaseString
    }
    
    func daySuffix(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dayOfMonth = calendar.component(.Day, fromDate: date)
        switch dayOfMonth {
        case 1: fallthrough
        case 21: fallthrough
        case 31: return "st"
        case 2: fallthrough
        case 22: return "nd"
        case 3: fallthrough
        case 23: return "rd"
        default: return "th"
        }
    }
}