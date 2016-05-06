//
//  CharacterTableViewManager.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

enum CharacterDetailsCellType {
    case Image
    case Text
    case ContentsTableView
    case Title
    case Link
}

struct CharacterDetailsCellModel {
    var type : CharacterDetailsCellType
    var title : String
    var dataObject : AnyObject
    
    init (aType : CharacterDetailsCellType, aTitle : String, aDataObject : AnyObject) {
        type = aType
        title = aTitle
        dataObject = aDataObject
    }
}

class CharacterDetailsTableViewManager: NSObject {
    var character : Character? {
        didSet {
            generateTableViewModel()
        }
    }
    private var cellModelsArray = [CharacterDetailsCellModel]()
    private var contentTableView : BaseTableView?
    
    private func generateTableViewModel() {
        cellModelsArray.removeAll()
        
        if let thumbnailImageLink = character?.thumbnailImage?.downloadURL {
            cellModelsArray.append(CharacterDetailsCellModel(aType: .Image, aTitle: "", aDataObject: thumbnailImageLink))
        }
        if let name = character?.name where character?.name?.length > 0 {
            cellModelsArray.append(CharacterDetailsCellModel(aType: .Text, aTitle: "NAME".localized(), aDataObject: name))
        }
        if let info = character?.charcterDescription where character?.charcterDescription?.length > 0 {
            cellModelsArray.append(CharacterDetailsCellModel(aType: .Text, aTitle: "DESCRIPTION".localized(), aDataObject: info))
        }
        if let contentsArray = character?.containedLists?.allObjects as? [ContentsCharacter] {
            for contents in contentsArray {
                if let type = contents.type?.integerValue, let summaries = contents.items?.allObjects as? [ContentSummary] {
                    if summaries.count > 0 {
                        cellModelsArray.append(CharacterDetailsCellModel(aType: .ContentsTableView, aTitle: ContentsCharacterType(rawValue: type)!.toString(), aDataObject: summaries))
                    }
                }
            }
        }
        if let linksArray = character?.webURLs?.allObjects as? [WebURL] {
            if linksArray.count > 0 {
                cellModelsArray.append(CharacterDetailsCellModel(aType: .Title, aTitle: "RELATED LINKS".localized(), aDataObject: linksArray))
                for link in linksArray {
                    if let type = link.type {
                        cellModelsArray.append((CharacterDetailsCellModel(aType: .Link, aTitle: type.capitalizedString, aDataObject: link)))
                    }
                }
            }
        }
        
        contentTableView?.reloadData()
    }
}

// MARK: UITableViewDelegate protocol

extension CharacterDetailsTableViewManager : UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let webURL = cellModelsArray[indexPath.row].dataObject as? WebURL {
            DisplayManager.sharedInstance.showWebPageWithString(webURL.url)
        }
    }
}

// MARK: UITableViewDatasource protocol

extension CharacterDetailsTableViewManager : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let modelObject = cellModelsArray[indexPath.row]
        
        switch modelObject.type {
        case .Image:
            let cell = CharacterImageDetailsTableViewCell(style: .Default, reuseIdentifier: CharacterImageDetailsTableViewCell.reuseIdentifier())
            
            cell.titleLabel.text = modelObject.title
            cell.characterImageView.setImageWithUrlPath(modelObject.dataObject as? String)
            
            return cell
        case .Text:
            let cell = CharacterTextDetailsTableViewCell(style: .Default, reuseIdentifier: CharacterTextDetailsTableViewCell.reuseIdentifier())
            
            cell.titleLabel.text = modelObject.title
            cell.infoLabel.text = modelObject.dataObject as? String
            
            return cell
        case .ContentsTableView:
            let cell = CharacterContentsDetailsTableViewCell(style: .Default, reuseIdentifier: CharacterContentsDetailsTableViewCell.reuseIdentifier())
            
            cell.titleLabel.text = modelObject.title
            let tableManager = CharacterContentsTableViewManager()
            tableManager.contentTableView = cell.tableView
            if let summaries = modelObject.dataObject  as? [ContentSummary] {
                tableManager.summariesArray = summaries
            }
            cell.tableView.delegate = tableManager
            
            return cell
        case .Title:
            let cell = CharacterBaseDetailsTableViewCell(style: .Default, reuseIdentifier: CharacterBaseDetailsTableViewCell.reuseIdentifier())
            cell.titleLabel.text = modelObject.title
            cell.titleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: cell.elementsOffset)
            return cell
        case .Link:
            let reuseIdentifier = "CharacterLinkTableViewCell\(indexPath.row)"
            let cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
            
            cell.textLabel?.text = modelObject.title
            cell.accessoryView = BaseImageView(image: R.image.icnCellDisclosure)
            cell.textLabel?.font = UIFont.systemFontOfSize(17)
            cell.textLabel?.textColor = .whiteColor()
            cell.selectionStyle = .None
            cell.backgroundColor = .clearColor()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentTableView = tableView as? BaseTableView
        return cellModelsArray.count
    }
}
