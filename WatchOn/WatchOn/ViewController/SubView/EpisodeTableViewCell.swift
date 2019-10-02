//
//  EpisodeTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 02/10/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var sEpisodeNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.sEpisodeNameLB.text = ""
    }

    func setupCell(episodeIn: Episode) {
        self.sEpisodeNameLB.text = episodeIn.eName
    }

}
