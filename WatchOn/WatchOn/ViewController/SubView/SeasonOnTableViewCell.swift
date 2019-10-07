//
//  SeasonOnTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 02/10/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SeasonOnTableViewCell: UITableViewCell {

    @IBOutlet weak var mSeasonNameLB: UILabel!
    @IBOutlet weak var mEpisodesTV: UITableView!
    
    private var mEpisodeData: [Episode] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.mSeasonNameLB.text = ""
    }

    func setupCell(seasonIn: Season?, indexIn: Int) {
        mEpisodesTV.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        mEpisodesTV.delegate = self
        mEpisodesTV.dataSource = self
        
        self.mSeasonNameLB.text = seasonIn?.sName
        
        if seasonIn != nil {
            mEpisodeData = seasonIn?.sEpisodes ?? []
            if mEpisodeData.isEmpty {
                SerieContentPresenter.sharedInstance.getSerieContentDetailEpisodeBySeason(seasonIndexIn: indexIn)
            }else{
                mEpisodesTV.reloadData()
            }
        }else{
            SerieContentPresenter.sharedInstance.getSerieContentDetailEpisodeBySeason(seasonIndexIn: indexIn)
        }
    }
}

extension SeasonOnTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mEpisodeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeTableViewCell
        episodeCell.setupCell(episodeIn: mEpisodeData[indexPath.row])
        return episodeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let episodeCell = tableView.cellForRow(at: indexPath) as? EpisodeTableViewCell {
            episodeCell.setEpisodeSelected()
        }
    }
}
