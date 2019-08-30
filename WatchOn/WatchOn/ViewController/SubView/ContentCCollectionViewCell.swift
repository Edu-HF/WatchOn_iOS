//
//  ContentCCollectionViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 29/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class ContentCCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentCellIMG: UIImageView!
    @IBOutlet weak var contentCellTitleLB: UILabel!
    @IBOutlet weak var contentCellCategoriesLB: UILabel!
    
    private var mainContentData: [Content] = []
    private var cTimer: Timer!
    private var currentIndex: Int = 0
    private let loadIMGOptions = ImageLoadingOptions(
        placeholder: UIImage(named: ""),
        transition: .fadeIn(duration: 0.33)
    )
    
    // MARK: Cell Methods
    func setupCell(contentDataIn: [Content]) {
        
        mainContentData = contentDataIn
        
        cTimer != nil ? cTimer.invalidate() : self.updateContent()
        cTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            self.changeContent()
        })
    }
    
    private func changeContent() {
        
        if mainContentData.count != 0 {
            if currentIndex == mainContentData.count - 1 {
                currentIndex = 0
            }else {
                currentIndex += 1
            }
            
            updateContent()
        }
    }
    
    private func updateContent() {
        
        DispatchQueue.main.async {
            if let posterPath = self.mainContentData[self.currentIndex].contentPosterPath {
                if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                    Nuke.loadImage(with: posterURL, options: self.loadIMGOptions, into: self.contentCellIMG)
                    self.contentCellIMG.contentMode = .scaleAspectFill
                }
            }
        }
        
        contentCellTitleLB.text = mainContentData[currentIndex].contentTitle
        contentCellCategoriesLB.text = "TRAMA - ACTION - AVENTURA"
    }
    
}
