//
//  CharacterContentsTableViewManager.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterContentsTableViewManager: NSObject {
    var summariesArray = [ContentSummary]() {
        didSet {
            contentTableView?.reload()
        }
    }
    var contentTableView : EasyTableView?
}

//MARK: Table view delegate

extension CharacterContentsTableViewManager : EasyTableViewDelegate {
    func easyTableView(easyTableView: EasyTableView!, numberOfRowsInSection section: Int) -> Int {
        return summariesArray.count
    }
    
    func easyTableView(tableView: EasyTableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        DisplayManager.sharedInstance.showContentSummaryInArray(summariesArray, forIndex: indexPath.row)
    }
    
    func easyTableView(easyTableView: EasyTableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let reuseIdentifier = "ContentsTableViewCellReuseIdentifier"
        var cell = easyTableView.tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? ContentsTableViewCell
        if cell == nil {
            cell = ContentsTableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        }
        
        summariesArray[indexPath.row].imageURL {[weak cell] (imageURL) in
            cell?.contentImageView.setImageWithUrlPath(imageURL)
        }
        cell?.contentNameLabel.text = summariesArray[indexPath.row].name
        cell?.contentNameLabel.sizeToFit()
        
        return cell!
    }
}
