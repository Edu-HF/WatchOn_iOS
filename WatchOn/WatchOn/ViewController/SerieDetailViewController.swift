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
        NotificationCenter.default.addObserver(self, selector: #selector(showEpisode), name: .ShowEpisodeNoti, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UpdateEpisodesNoti, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ShowEpisodeNoti, object: nil)
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "DetailUKey".localized())
        serieContentTV.register(UINib(nibName: "SeasonOffCell", bundle: nil), forCellReuseIdentifier: "SeasonOffCell")
        serieContentTV.register(UINib(nibName: "SeasonOnCell", bundle: nil), forCellReuseIdentifier: "SeasonOnCell")
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
            self.updateTV()
        }
        
        SerieContentPresenter.sharedInstance.mainErrorResponse?.bind { errorIn in
            self.showSomeMSGAlert(titleIn: "OupsErrorKey".localized(), msgIn: errorIn.localizedDescription)
        }
        
        SerieContentPresenter.sharedInstance.getSerieContentDetail()
    }
    
    @objc private func updateTV() {
        DispatchQueue.main.async {
            self.serieContentTV.reloadData()
        }
    }
    
    @objc private func showEpisode() {
        DispatchQueue.main.async {
            let mMediaPlayerVC = MainMediaPlayerViewController()
            mMediaPlayerVC.mPlayerTypeContent = .SerieChapterType
            self.present(mMediaPlayerVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func serieSintaxisBtn(_ sender: Any) {
        mCellType = .SintaxisCell
        self.updateTV()
    }
    
    @IBAction func serieEpisodesBtn(_ sender: Any) {
        mCellType = .EpisodesCell
        self.updateTV()
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
            detailCell.setupCell()
            
            return detailCell
        case .EpisodesCell:
            if let mSeason = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row] {
                
                if mSeason.sIsSelected ?? false {
                    let seasonOnCell = tableView.dequeueReusableCell(withIdentifier: "SeasonOnCell") as! SeasonOnTableViewCell
                    seasonOnCell.setupCell(seasonIn: mSeason, indexIn: indexPath.row)
                    return seasonOnCell
                }else {
                    let seasonOffCell = tableView.dequeueReusableCell(withIdentifier: "SeasonOffCell") as! SeasonOffTableViewCell
                    seasonOffCell.setupCell(seasonIn: mSeason)
                    return seasonOffCell
                }
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row].sIsSelected = true
        self.updateTV()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch mCellType {
        case .SintaxisCell:
            return 456
        case .EpisodesCell:
            if let mSeason = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value.serieSeasons?[indexPath.row] {
                if mSeason.sIsSelected ?? false {
                    let eCount = mSeason.sEpisodes?.count ?? 0
                    if eCount == 0 {
                        return 100
                    }else{
                        let itemH = 50 * eCount
                        return CGFloat(itemH + 70)
                    }
                }else {
                    return 50
                }
            }
            return 0
        }
    }
}
