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
    
    override func loadView() {
        //Set up content view
        super.loadView()
        layoutContentView(contentView)
        navigationController?.view.addSubview(searchView)
        searchView.autoPinEdgesToSuperviewEdges()
        
        contentView.tableView.datasourceManager = CharactersTableViewManager()
        contentView.tableView.datasourceManager?.listType = .List
        
        searchView.tableView.datasourceManager = CharactersTableViewManager()
        searchView.tableView.datasourceManager?.listType = .Search
        searchView.searchBar.delegate = self
        
        //Set up navigation bar
        navigationController?.navigationBar.backgroundColor = MDColors.blackColor()
        navigationController?.navigationBar.setBackgroundImage(MDColors.blackColor().toImage(), forBarMetrics: UIBarMetrics.Default)
        navigationItem.titleView = UIImageView(image: R.image.icnNavMarvel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icnNavSearch, style: .Plain, target: self, action: #selector(CharactersListViewController.searchButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = MDColors.redColor()
        
        //Subscribe to keyboard appearance
        startObservingKeyboardChanges()
        
        //Set up data
        contentView.tableView.animateLoading()
        contentView.tableView.datasourceManager?.reloadData()
    }
    
    deinit {
        endObservingKeyboardChanges()
    }
}

// MARK: Actions

extension CharactersListViewController {
    func searchButtonTapped(button : UIBarButtonItem) {
        searchView.reverseHiddenState()
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
        searchView.searchBar.resignFirstResponder()
        searchBar.enableCancelButton()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchView.reverseHiddenState()
        searchView.tableView.datasourceManager?.filterString = nil
        searchView.searchBar.resignFirstResponder()
        searchBar.enableCancelButton()
    }
}
