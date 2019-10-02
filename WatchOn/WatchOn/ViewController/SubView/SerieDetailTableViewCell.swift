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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        mSintaxisLB.text = ""
    }

    func setupCell() {
        let serieDetail = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value
        
        mSintaxisLB.text = serieDetail.serieSintaxis
    }
    
}
