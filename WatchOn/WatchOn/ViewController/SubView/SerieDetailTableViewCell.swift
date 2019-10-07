//
//  SerieDetailTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 26/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SerieDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mSintaxisLB: UITextView!
    @IBOutlet weak var mLanIMG: UIImageView!
    @IBOutlet weak var mRatingNumLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        mSintaxisLB.text = ""
        mLanIMG.image = nil
        mRatingNumLB.text = ""
    }

    func setupCell() {
        let serieDetail = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value
        
        mSintaxisLB.text = serieDetail.serieSintaxis
        mRatingNumLB.text = String(serieDetail.serieVoteAverage ?? 0.0)
    }
    
    
}
