//
//  FavTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 11/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

class FavTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mFavIMG: UIImageView!
    @IBOutlet weak var mFavTitleLB: UILabel!
    @IBOutlet weak var mFavSubTitleLB: UILabel!
    @IBOutlet weak var mFavTypeLB: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        
        mFavIMG.image = nil
        mFavTitleLB.text = ""
        mFavSubTitleLB.text = ""
        mFavTypeLB.text = ""
    }

    func setupCell(mFavIn: FavContent?) {
        
        mFavIMG.image = UIImage(named: "IMGPlaceHolder_IC")
        
        if mFavIn != nil {
            DispatchQueue.main.async {
                if let posterPath = mFavIn?.cFavIMG {
                    if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                        Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.mFavIMG, progress: nil, completion: { _ in
                            self.mFavIMG.resizeIMGToFrame()
                        })
                    }
                }
            }
            
            mFavTitleLB.text = mFavIn?.cFavName
            mFavSubTitleLB.text = mFavIn?.cFavSubName
            mFavTypeLB.text = mFavIn?.cFavType
        }
    }
}
