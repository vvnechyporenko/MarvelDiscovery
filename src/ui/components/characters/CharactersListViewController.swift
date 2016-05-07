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
    private let searchView = CharactersSearchView()
    private let searchBar = UISearchBar()
    
    override func loadView() {
        //Set up navigation bar
        navigationItem.titleView = UIImageView(image: R.image.icnNavMarvel)
        setUpRightBarButtonItem()
        
        //Set up content view
        super.loadView()
        layoutContentView(contentView)
        layoutContentView(searchView)
        
        contentView.tableView.datasourceManager = CharactersTableViewManager()
        contentView.tableView.datasourceManager?.listType = .List
        
        searchView.tableView.datasourceManager = CharactersTableViewManager()
        searchView.tableView.datasourceManager?.listType = .Search
        
        //Set up search bar
        setUpSearchBar()
        
        //Subscribe to keyboard appearance
        startObservingKeyboardChanges()
        
        //Set up data
        contentView.tableView.animateLoading()
        contentView.tableView.datasourceManager?.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(MDColors.blackColor().toImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.translucent = false
        searchBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.bringSubviewToFront(searchBar)
    }
    
    private func setUpRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icnNavSearch, style: .Plain, target: self, action: #selector(CharactersListViewController.searchButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = MDColors.redColor()
    }
    
    private func setUpSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.alpha = 0
        searchBar.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0), excludingEdge: .Bottom)
        searchBar.delegate = self
        searchBar.tintColor = MDColors.redColor()
        searchBar.backgroundImage = MDColors.blackColor().toImage()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search...".localized()
        searchBar.enableCancelButton()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.hidden = true
        searchBar.resignFirstResponder()
        searchBar.enableCancelButton()
    }
    
    deinit {
        endObservingKeyboardChanges()
    }
}

// MARK: Animation

extension CharactersListViewController {
    func reverseSearchHiddenState() {
        if self.searchView.alpha == 0 {
            self.navigationItem.rightBarButtonItem = nil
        }
        else {
            self.setUpRightBarButtonItem()
        }
        UIView.animateWithDuration(0.33) {
            self.searchView.alpha = self.searchView.alpha == 0 ? 1 : 0
            self.searchBar.alpha = self.searchBar.alpha == 0 ? 1 : 0
        }
    }
}

// MARK: Actions

extension CharactersListViewController {
    func searchButtonTapped(button : UIBarButtonItem) {
        reverseSearchHiddenState()
        if searchView.tableView.datasourceManager?.filterString == nil || searchView.tableView.datasourceManager?.filterString?.length == 0 {
            searchBar.becomeFirstResponder()
        }
    }
}

// MARK: Keyboard observing

extension CharactersListViewController {
    override func keyboardWillHide() {
        searchView.keyboardWillHide()
    }
    
    override func keyboardWillShowWithSize(keyboardSize: CGSize) {
        searchView.keyboardWillShowWithSize(keyboardSize)
    }
}

// MARK: Search delegate

extension CharactersListViewController : UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.enableCancelButton()
        searchView.tableView.datasourceManager?.filterString = searchBar.text
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.enableCancelButton()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        reverseSearchHiddenState()
        searchView.tableView.datasourceManager?.filterString = nil
        searchBar.resignFirstResponder()
        searchBar.enableCancelButton()
    }
}
