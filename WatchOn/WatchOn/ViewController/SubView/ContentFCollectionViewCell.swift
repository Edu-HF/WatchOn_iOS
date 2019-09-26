//
//  ContentFCollectionViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 24/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

enum SerieCellType: String {
    case SintaxisCell, EpisodesCell
}

class ContentFCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serieContentIMG: UIImageView!
    @IBOutlet weak var serieContentTV: UITableView!
    @IBOutlet weak var serieContentOriginalNameLB: UILabel!
    @IBOutlet weak var serieContentNameLB: UILabel!
    
    private var mCellType: SerieCellType = .SintaxisCell
    
    override func awakeFromNib() {
        
    }
    
    func setupCell() {
        
        serieContentTV.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        serieContentTV.register(UINib(nibName: "SerieDetailCell", bundle: nil), forCellReuseIdentifier: "SerieDetailCell")
    }
    
    @IBAction func serieSintaxisBtn(_ sender: Any) {
        mCellType = .SintaxisCell
        serieContentTV.reloadData()
    }
    
    @IBAction func serieEpisodesBtn(_ sender: Any) {
        mCellType = .EpisodesCell
        serieContentTV.reloadData()
    }
}

extension ContentFCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mCellType {
        case .SintaxisCell:
            return 1
        case .EpisodesCell:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch mCellType {
        case .SintaxisCell:
            let detailCell = tableView.dequeueReusableCell(withIdentifier: "SerieDetailCell") as! SerieDetailTableViewCell
            
            return detailCell
        case .EpisodesCell:
            let episodesCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeTableViewCell
            
            return episodesCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch mCellType {
        case .SintaxisCell:
            return 250
        case .EpisodesCell:
            return 50
        }
    }
}
