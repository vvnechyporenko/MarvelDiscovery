//
//  CharactersTableViewManager.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

enum CharacterListUIType {
    case List
    case Search
}

class CharactersTableViewManager: NSObject {
    var listType : CharacterListUIType?
    var filterString : String? {
        didSet {
            if filterString != oldValue {
                contentTableView?.animateLoading()
                isDataLoading = false
                loadCharactersWithFullReload(true)
            }
        }
    }
    
    private var charactersArray = [Character]()
    private var totalCharactersCount = 0
    private var isDataLoading = false
    private var contentTableView : BaseTableView?
    
    
    func reloadData() {
        loadCharactersWithFullReload()
    }
    
    private func canLoadMoreCharacters() -> Bool {
        return totalCharactersCount > charactersArray.count
    }
    
    private func loadCharactersWithFullReload(fullReload : Bool = true) -> Bool {
        if (fullReload == false && canLoadMoreCharacters() == false) || isDataLoading == true {
            contentTableView?.endLoading()
            return false
        }
        
        if (filterString?.length > 0) == false && listType == .Search {
            charactersArray = [Character]()
            contentTableView?.reloadData()
            contentTableView?.endLoading()
            return false
        }
        
        isDataLoading = true
        
        let offset = fullReload == true ? 0 : charactersArray.count
        
        NetworkManager.sharedInstance.getCharactersWithOffset(offset, filterName: filterString) {[weak self] (characters, totalCount, filterName, error) in
            self?.contentTableView?.endLoading()
            self?.isDataLoading = false
            if filterName != self?.filterString {
                return
            }
            if let error = error {
                DisplayManager.sharedInstance.currentViewController?.showError(error)
            }
            else if let characters = characters {
                if fullReload == true {
                    self?.charactersArray = characters
                    self?.contentTableView?.reloadData()
                }
                else if let oldCharactersCount = self?.charactersArray.count where self?.charactersArray.count > 0 {
                    self?.charactersArray.appendContentsOf(characters)
                    var pathsArray = [NSIndexPath]()
                    for i in oldCharactersCount ... (oldCharactersCount + characters.count)-1 {
                        pathsArray.append(NSIndexPath(forRow: i, inSection: 0))
                    }
                    self?.contentTableView?.insertRowsAtIndexPaths(pathsArray, withRowAnimation: .Fade)
                }
            }
            
            if let totalCount = totalCount {
                self?.totalCharactersCount = totalCount
            }
        }
        
        return true
    }
}

// MARK: UITableViewDelegate protocol 

extension CharactersTableViewManager : UITableViewDelegate, TableViewRefreshDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        DisplayManager.sharedInstance.showCharacterDetailsWithCharacter(charactersArray[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return listType == .List ? 160 : 65
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if canLoadMoreCharacters() == false || (charactersArray.count - indexPath.row) > 10 || indexPath.row == 0  {
            return
        }
        
        if loadCharactersWithFullReload(false) == true {
            contentTableView?.animateBottomLoading()
        }
    }
    
    func tableView(tableView : BaseTableView, asksReloadWithControl refreshControl : UIRefreshControl) {
        loadCharactersWithFullReload()
    }
}

// MARK: UITableViewDatasource protocol

extension CharactersTableViewManager : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let classForCell = listType == .List ? CharacterTableViewCell.self : CharacterSearchTableViewCell.self
        
        var cell = tableView.dequeueReusableCellWithIdentifier(classForCell.reuseIdentifier()) as? CharacterTableViewCell
        if cell == nil {
            if listType == .List {
                cell = CharacterTableViewCell(style: .Default, reuseIdentifier: classForCell.reuseIdentifier())
            }
            else {
                cell = CharacterSearchTableViewCell(style: .Default, reuseIdentifier: classForCell.reuseIdentifier())
            }
        }
        
        cell?.characterImageView.setImageWithUrlPath(charactersArray[indexPath.row].thumbnailImage?.downloadURL)
        cell?.nameLabel.text = charactersArray[indexPath.row].name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentTableView = tableView as? BaseTableView
        return charactersArray.count
    }
}
