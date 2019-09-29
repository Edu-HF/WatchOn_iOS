//
//  SerieDetailViewController.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 27/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit
import Nuke

private enum SerieCellType: String {
    case SintaxisCell, EpisodesCell
}

class SerieDetailViewController: BaseViewController {

    @IBOutlet weak var serieContentIMG: UIImageView!
    @IBOutlet weak var serieContentTV: UITableView!
    @IBOutlet weak var serieContentOriginalNameLB: UILabel!
    @IBOutlet weak var serieContentNameLB: UILabel!
    
    private var mCellType: SerieCellType = .SintaxisCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTV), name: .UpdateEpisodesNoti, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UpdateEpisodesNoti, object: nil)
    }
    
    private func setupView() {
        
        serieContentTV.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        serieContentTV.register(UINib(nibName: "SeasonCell", bundle: nil), forCellReuseIdentifier: "SeasonCell")
        serieContentTV.register(UINib(nibName: "SerieDetailCell", bundle: nil), forCellReuseIdentifier: "SerieDetailCell")
        
        serieContentNameLB.text = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieName
        serieContentOriginalNameLB.text = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieOriginalName
        
        DispatchQueue.main.async {
            if let posterPath = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieBackDropPath {
                if let posterURL = URL(string: posterPath.buildURLStringIMG()) {
                    Nuke.loadImage(with: posterURL, options: ImageLoadingOptions().loadIMGBaseOptions(), into: self.serieContentIMG, progress: nil, completion: { _ in
                        self.serieContentIMG.resizeIMGToFrame()
                    })
                }
            }
        }
        
        setupListeners()
    }
    
    private func setupListeners() {
        
        SerieContentPresenter.sharedInstance.mainSerieContentSelected.bind { _ in
            self.serieContentTV.reloadData()
        }
        
        SerieContentPresenter.sharedInstance.mainErrorResponse?.bind { errorIn in
            self.showSomeMSGAlert(titleIn: "OupsErrorKey".localized(), msgIn: errorIn.localizedDescription)
        }
        
        SerieContentPresenter.sharedInstance.getSerieContentDetail()
    }
    
    @objc private func updateTV() {
        self.serieContentTV.reloadData()
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

extension SerieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mCellType {
        case .SintaxisCell:
            return 1
        case .EpisodesCell:
            return SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch mCellType {
        case .SintaxisCell:
            let detailCell = tableView.dequeueReusableCell(withIdentifier: "SerieDetailCell") as! SerieDetailTableViewCell
            
            return detailCell
        case .EpisodesCell:
            if let mSeason = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row] {
                
                if mSeason.sIsSelected ?? false {
                    let seasonCell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell") as! SeasonTableViewCell
                    seasonCell.setupCell(seasonIn: mSeason, indexIn: indexPath.row)
                    return seasonCell
                }else {
                    let episodesCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeTableViewCell
                    episodesCell.setupCell(seasonIn: mSeason, episodeIn: nil)
                    return episodesCell
                }
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row].sIsSelected = true
        self.serieContentTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch mCellType {
        case .SintaxisCell:
            return 250
        case .EpisodesCell:
            if let mSeason = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row] {
                if mSeason.sIsSelected ?? false {
                    let eCount = mSeason.sEpisodes?.count ?? 0
                    if eCount == 0 {
                        return 100
                    }else{
                        return CGFloat(50*eCount + 70)
                    }
                }else {
                    return 50
                }
            }
            return 0
        }
    }
}
