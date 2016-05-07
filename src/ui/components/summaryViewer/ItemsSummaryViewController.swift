//
//  ItemsSummaryViewController.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/7/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

class ItemsSummaryViewController: BaseViewController {
    var summaryArray : [ContentSummary]?
    var currentIndex = 0
    
    let contentView = ItemsSummaryView()
    
    override func loadView() {
        super.loadView()
        
        layoutContentView(contentView)
        contentView.delegate = self
        contentView.reloadData()
        contentView.closeButton.addTarget(self, action: #selector(ItemsSummaryViewController.closeButtonTapped), forControlEvents: .TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        contentView.scrollView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * screenWidth(), y: 0), animated: true)
        contentView.currentPage = currentIndex + 1
    }
    
    func closeButtonTapped() {
        dismissPopupViewController(SLpopupViewAnimationType.Fade)
    }
}

// MARK: ContentView delegate

extension ItemsSummaryViewController : ItemsSummaryViewDelegate {
    func itemsSummaryViewAsksNumberOfItems(summaryView: ItemsSummaryView) -> Int {
        if let summaryArray = summaryArray {
            return summaryArray.count
        }
        return 0
    }
    
    func itemsSummaryView(summaryView: ItemsSummaryView, asksToFillDataForCoverView coverView: ItemCoverView, atIndex index: Int) {
        guard let summaryArray = summaryArray else {
            return
        }
        coverView.titleLabel.text = summaryArray[index].name
        summaryArray[index].imageURL { (imageURL) in
            coverView.imageView.setImageWithUrlPath(imageURL)
        }
    }
}
