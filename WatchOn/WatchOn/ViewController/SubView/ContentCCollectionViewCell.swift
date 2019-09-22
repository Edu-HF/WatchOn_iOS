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
    @IBOutlet weak var contentBGView: UIView!
    @IBOutlet weak var contentCellTitleLB: UILabel!
    @IBOutlet weak var contentCellCategoriesLB: UILabel!
    
    private var mainContentData: [Content] = []
    private var cTimer: Timer!
    private var currentIndex: Int = 0
    private var contentTapped: ContentTappedProtocol!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                contentTapped.onContentTapped(contentIn: mainContentData[currentIndex])
            }
        }
    }
    
    // MARK: Cell Methods
    func setupCell(contentDataIn: [Content], onContentTappedIn: ContentTappedProtocol) {
        
        contentBGView.applyGradientFromBottom(colorIn: .homeBackground2)
        mainContentData = contentDataIn
        contentTapped = onContentTappedIn
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
                    Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.contentCellIMG, progress: nil, completion: { _ in
                        self.contentCellIMG.resizeIMGToFrame()
                    })
                }
            }
        }
        
        contentCellTitleLB.text = mainContentData[currentIndex].contentTitle
        contentCellCategoriesLB.text = String().buildGenderNamesString(contentGenrersIn: mainContentData[currentIndex].contentGenrersID ?? [])
    }
    
    @IBAction func makePlayContentAct(_ sender: Any) {
        contentTapped.onContentTappedForPlay(contentIn: mainContentData[currentIndex])
    }
}

