//
//  ContentBCollectionViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 08/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class ContentBCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentCellIMG: UIImageView!
    @IBOutlet weak var contentCellTitleLB: UILabel!
    @IBOutlet weak var contentCellDescripLB: UILabel!
    
    private let loadIMGOptions = ImageLoadingOptions(
        placeholder: UIImage(named: ""),
        transition: .fadeIn(duration: 0.33)
    )
    
    // MARK: Cell Methods
    override func prepareForReuse() {
        contentCellIMG.image = nil
        contentCellTitleLB.text = ""
        contentCellDescripLB.text = ""
    }
    
    func setupCell(contentIn: Content) {
        
        DispatchQueue.main.async {
            if let posterPath = contentIn.contentPosterPath {
                if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                    Nuke.loadImage(with: posterURL, options: self.loadIMGOptions, into: self.contentCellIMG)
                    self.contentCellIMG.contentMode = .scaleAspectFill
                }
            }
        }
        
        contentCellTitleLB.text = contentIn.contentTitle
        contentCellDescripLB.text = contentIn.contentOriginalTitle
    }
}
