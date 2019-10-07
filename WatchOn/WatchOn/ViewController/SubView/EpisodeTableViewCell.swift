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
    private var mEpisode: Episode!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.sEpisodeNameLB.text = ""
        self.mEpisode = nil
    }

    func setupCell(episodeIn: Episode) {
        self.mEpisode = episodeIn
        self.sEpisodeNameLB.text = self.mEpisode.eName
    }

    func setEpisodeSelected() {
        if self.mEpisode != nil {
            SerieContentPresenter.sharedInstance.setEpisodeSelected(episodeIn: self.mEpisode)
        }
    }
}
