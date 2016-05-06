//
//  CharactersListViewController.swift
//  MarvelDiscovery
//
//  Created by winmons on 4/30/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharactersListViewController: BaseViewController {
    private let contentView = CharactersListView()
    private var charactersArray = [Character]()
    private var totalCharactersCount = 0
    private var isDataLoading = false
    
    override func loadView() {
        //Set up content view
        super.loadView()
        layoutContentView(contentView)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.refreshDelegate = self
        
        //Set up navigation bar
        navigationController?.navigationBar.backgroundColor = MDColors.blackColor()
        navigationController?.navigationBar.setBackgroundImage(MDColors.blackColor().toImage(), forBarMetrics: UIBarMetrics.Default)
        navigationItem.titleView = UIImageView(image: R.image.icnNavMarvel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icnNavSearch, style: .Plain, target: self, action: #selector(CharactersListViewController.searchButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = MDColors.redColor()
        
        //Set up data
        contentView.animateLoading()
        loadCharactersWithFullReload()
    }
}

// MARK: Data management

extension CharactersListViewController {
    private func loadCharactersWithFullReload(fullReload : Bool = true) -> Bool {
        if (fullReload == false && canLoadMoreCharacters() == false) || isDataLoading == true {
            contentView.endLoading()
            return false
        }
        
        isDataLoading = true
        
        let offset = fullReload == true ? 0 : charactersArray.count
        
        NetworkManager.sharedInstance.getCharactersWithOffset(offset) {[weak self] (characters, totalCount, error) in
            self?.contentView.endLoading()
            self?.isDataLoading = false
            if let error = error {
                self?.showError(error)
            }
            else if let characters = characters {
                if fullReload == true {
                    self?.charactersArray = characters
                    self?.contentView.tableView.reloadData()
                }
                else if let oldCharactersCount = self?.charactersArray.count where self?.charactersArray.count > 0 {
                    self?.charactersArray.appendContentsOf(characters)
                    var pathsArray = [NSIndexPath]()
                    for i in oldCharactersCount ... (oldCharactersCount + characters.count)-1 {
                        pathsArray.append(NSIndexPath(forRow: i, inSection: 0))
                    }
                    self?.contentView.tableView.insertRowsAtIndexPaths(pathsArray, withRowAnimation: .Fade)
                }
            }
            
            if let totalCount = totalCount {
                self?.totalCharactersCount = totalCount
            }
        }
        
        return true
    }
    
    private func canLoadMoreCharacters() -> Bool {
        return totalCharactersCount > charactersArray.count
    }
}

// MARK: Action

extension CharactersListViewController {
    func searchButtonTapped(button : UIBarButtonItem) {
        
    }
}

// MARK: TableView delegate/datasource

extension CharactersListViewController : UITableViewDelegate, UITableViewDataSource, TableViewRefreshDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CharacterTableViewCell.reuseIdentifier()) as? CharacterTableViewCell
        if cell == nil {
            cell = CharacterTableViewCell(style: .Default, reuseIdentifier: CharacterTableViewCell.reuseIdentifier())
        }
        
        cell?.characterImageView.setImageWithUrlPath(charactersArray[indexPath.row].thumbnailImage?.downloadURL)
        cell?.nameLabel.text = charactersArray[indexPath.row].name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if canLoadMoreCharacters() == false || (charactersArray.count - indexPath.row) > 10 || indexPath.row == 0  {
            return
        }
        
        if loadCharactersWithFullReload(false) == true {
            contentView.animateBottomLoading()
        }
    }
    
    func tableView(tableView : BaseTableView, asksReloadWithControl refreshControl : UIRefreshControl) {
        loadCharactersWithFullReload()
    }
}
