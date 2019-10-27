//
//  CastCollectionViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 31/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castMemberIMG: UIImageView!
    
    // MARK: Cell Methods
    override func prepareForReuse() {
        castMemberIMG.image = nil
    }
    
    func setupCell(castMemberIn: CastMember?) {
        DispatchQueue.main.async {
            if castMemberIn != nil {
                if let posterPath = castMemberIn!.castMemberProfilePath {
                    if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                        Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.castMemberIMG, progress: nil, completion: { _ in
                            self.castMemberIMG.resizeRoundedIMG()
                        })
                    }
                }
            }
        }
    }
}
