//
//  SeasonOffTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 02/10/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SeasonOffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mSeasonNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.mSeasonNameLB.text = ""
    }
    
    func setupCell(seasonIn: Season) {
        self.mSeasonNameLB.text = seasonIn.sName
    }

}
