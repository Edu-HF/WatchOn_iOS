//
//  FavTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 11/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

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

    func setupCell() {
        
        mFavIMG.image = UIImage(named: "IMGPlaceHolder_IC")
        mFavTitleLB.text = "The Avengers"
        mFavSubTitleLB.text = "The Age of Ultron"
        mFavTypeLB.text = "Movie"
    }
}
