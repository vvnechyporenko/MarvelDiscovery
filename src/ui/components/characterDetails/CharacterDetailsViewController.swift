//
//  CharacterDetailsViewController.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/6/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: BaseViewController {
    private let contentView = CharacterDetailsView()
    private let tableManager = CharacterDetailsTableViewManager()
    var character : Character? {
        didSet {
            tableManager.character = character
        }
    }
    
    override func loadView() {
        super.loadView()
        layoutContentView(contentView)
        contentView.tableView.delegate = tableManager
        contentView.tableView.dataSource = tableManager
        contentView.titleLabel.text = character?.name
        
        //Set up navigation bar
        navigationController?.navigationBar.makeTransparent()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icnNavBackWhite, style: .Plain, target: self, action: #selector(CharacterDetailsViewController.navigateBack))
        navigationItem.leftBarButtonItem?.tintColor = .whiteColor()
    }
}
