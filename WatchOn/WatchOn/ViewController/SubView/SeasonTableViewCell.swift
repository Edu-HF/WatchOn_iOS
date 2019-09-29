//
//  SeasonTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 28/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sNameLB: UILabel!
    @IBOutlet weak var sEpisodesTV: UITableView!
    @IBOutlet weak var sLoadingAI: UIActivityIndicatorView!
    
    private var mSeason: Season?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.preSetupCell()
    }

    override func prepareForReuse() {
        self.sNameLB.text = ""
    }
    
    private func preSetupCell() {
        self.sEpisodesTV.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        self.sEpisodesTV.dataSource = self
        self.sEpisodesTV.delegate = self
    }
    
    func setupCell(seasonIn: Season?, indexIn: Int) {
        self.mSeason = seasonIn
        self.sNameLB.text = seasonIn?.sName
        self.sEpisodesTV.reloadData()
        
        let eCount = seasonIn?.sEpisodes?.count ?? 0
        if eCount == 0 {
            SerieContentPresenter.sharedInstance.getSerieContentDetailEpisodeBySeason(seasonIndexIn: indexIn)
        }else{
            self.sLoadingAI.isHidden = true
            self.sEpisodesTV.reloadData()
        }
        
        if mSeason?.sEposidesNA == true {
            self.sLoadingAI.isHidden = true
            let naLB = UILabel.init(frame: CGRect.init(origin: sEpisodesTV.center, size: CGSize.init(width: 150, height: 20)))
            naLB.frame.origin.x = naLB.frame.origin.x - 75
            naLB.text = "No Disponible"
            naLB.textAlignment = .center
            naLB.textColor = .red
            self.addSubview(naLB)
        }
    }

}

extension SeasonTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mSeason?.sEpisodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episodesCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeTableViewCell
        return episodesCell
    }
    
}
