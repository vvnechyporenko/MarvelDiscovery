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
            print(summariesArray)
            contentTableView?.reload()
        }
    }
    var contentTableView : EasyTableView?
}

//MARK: Table view delegate

extension CharacterContentsTableViewManager : EasyTableViewDelegate {
    func easyTableView(easyTableView: EasyTableView!, numberOfRowsInSection section: Int) -> Int {
        contentTableView = easyTableView
        return summariesArray.count
    }
    
    func easyTableView(tableView: EasyTableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        DisplayManager.sharedInstance.showContentSummaryInArray(summariesArray, forIndex: indexPath.row)
    }
    
    func easyTableView(easyTableView: EasyTableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = easyTableView.tableView.dequeueReusableCellWithIdentifier(CharacterContentsDetailsTableViewCell.reuseIdentifier()) as? ContentsTableViewCell
        if cell == nil {
            cell = ContentsTableViewCell(style: .Default, reuseIdentifier: ContentsTableViewCell.reuseIdentifier())
        }
        
        cell?.contentImageView.setImageWithUrlPath(summariesArray[indexPath.row].resourceURI)
        cell?.contentNameLabel.text = summariesArray[indexPath.row].name
        
        return cell!
    }
}
