//
//  ItemsSummaryView.swift
//  MarvelDiscovery
//
//  Created by winmons on 5/7/16.
//  Copyright © 2016 nominanza. All rights reserved.
//

import UIKit

protocol ItemsSummaryViewDelegate {
    func itemsSummaryViewAsksNumberOfItems(summaryView : ItemsSummaryView) -> Int
    func itemsSummaryView(summaryView: ItemsSummaryView, asksToFillDataForCoverView coverView : ItemCoverView, atIndex index : Int)
}

class ItemsSummaryView: BaseView {

    var delegate : ItemsSummaryViewDelegate?
    let scrollView = UIScrollView()
    let closeButton = UIButton(image: R.image.icnNavCloseWhite)
    var currentPage = 0 {
        didSet {
            countLabel.text = "\(currentPage)/\(itemsCount)"
        }
    }
    private let countLabel = UILabel()
    private var itemsCount = 0
    
    override func setUpDefaults() {
        super.setUpDefaults()
        addSubviews(scrollView, countLabel, closeButton)
        backgroundColor = MDColors.charactersListBackgroundColor()
        
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        countLabel.textColor = MDColors.grayTextColor()
        countLabel.font = UIFont.systemFontOfSize(14)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        scrollView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 110, left: 0, bottom: 45, right: 0))
        
        closeButton.autoSetDimensionsToSize(CGSize(width: 44, height: 44))
        closeButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 20)
        closeButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        
        countLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: scrollView, withOffset: 5)
        countLabel.autoAlignAxisToSuperviewAxis(.Vertical)
    }
    
    func reloadData() {
        scrollView.constraints.forEach({ $0.autoRemove() })
        scrollView.removeAllSubviews()
        
        guard let numberOfItems = delegate?.itemsSummaryViewAsksNumberOfItems(self) else {
            return
        }
        
        itemsCount = numberOfItems
        if itemsCount <= 0 {
            return
        }
        
        var lastView : ItemCoverView?
        for index in 0 ... itemsCount-1 {
            let view = ItemCoverView()
            scrollView.addSubview(view)
            view.autoMatchDimension(.Height, toDimension: .Height, ofView: scrollView)
            view.autoPinEdgeToSuperviewEdge(.Top)
            view.autoPinEdgeToSuperviewEdge(.Bottom)
            let sideOffset : CGFloat = 25
            view.autoSetDimension(.Width, toSize: screenWidth() - sideOffset * 2)
            
            if index == 0 {
                view.autoPinEdgeToSuperviewEdge(.Left, withInset: sideOffset)
            }
            else if let lastView = lastView {
                view.autoPinEdge(.Left, toEdge: .Right, ofView: lastView, withOffset: sideOffset*2)
            }
            
            if index == itemsCount - 1 {
                view.autoPinEdgeToSuperviewEdge(.Right, withInset: sideOffset)
            }
            
            delegate?.itemsSummaryView(self, asksToFillDataForCoverView: view, atIndex: index)
            
            lastView = view
        }
    }
}

//MARK: ScrollView delegate

extension ItemsSummaryView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / screenWidth())+1
    }
}
