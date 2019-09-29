//
//  EpisodeTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 25/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeNameLB: UILabel!
    @IBOutlet weak var episodePlayBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        self.episodeNameLB.text = ""
        self.episodePlayBtn.setImage(nil, for: .normal)
    }
    
    func setupCell(seasonIn: Season?, episodeIn: Episode?) {
        
        if seasonIn != nil {
            episodeNameLB.text = seasonIn?.sName
            episodePlayBtn.setImage(UIImage.init(named: "PlayOn_IC"), for: .normal)
        }
        
        if episodeIn != nil {
            episodeNameLB.text = episodeIn?.eName
            episodePlayBtn.setImage(UIImage.init(named: "Play2On_IC"), for: .normal)
        }
    }
}
