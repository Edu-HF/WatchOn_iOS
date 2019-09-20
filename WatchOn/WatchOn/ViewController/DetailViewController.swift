//
//  DetailViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

private enum detailSection: String, CaseIterable {
    case DetailCoverCell, DetailActionBtnCell, DetailSinoxisCell, DetailRatingCell, DetailCastCell
}

class DetailViewController: BaseViewController {

    @IBOutlet weak var detailTV: UITableView!
    private lazy var sinoxisH: CGFloat = 0
    private var mainContentPresenter: ContentPresenter = ContentPresenter.sharedIntance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "Detail")
        detailTV.register(UINib(nibName: "DetailCoverCell", bundle: nil), forCellReuseIdentifier: "DetailCoverCell")
        detailTV.register(UINib(nibName: "DetailActionBtnCell", bundle: nil), forCellReuseIdentifier: "DetailActionBtnCell")
        detailTV.register(UINib(nibName: "DetailSinoxisCell", bundle: nil), forCellReuseIdentifier: "DetailSinoxisCell")
        detailTV.register(UINib(nibName: "DetailRatingCell", bundle: nil), forCellReuseIdentifier: "DetailRatingCell")
        detailTV.register(UINib(nibName: "DetailCastCell", bundle: nil), forCellReuseIdentifier: "DetailCastCell")
        detailTV.estimatedRowHeight = 400
        detailTV.rowHeight = UITableView.automaticDimension
        
        setupListeners()
    }
    
    private func setupListeners() {
        
        mainContentPresenter.mainContentSelected.contentCast.bind { castDataIn in
            self.detailTV.reloadData()
        }
        
        mainContentPresenter.mainContentSelected.contentMedia.bind { mediaDataIn in
            self.detailTV.reloadData()  
        }
        
        mainContentPresenter.getCast(contentIn: mainContentPresenter.mainContentSelected)
        mainContentPresenter.getContentMedia(contentIn: mainContentPresenter.mainContentSelected)
    }
    
    @objc private func contentPlayMedia() {
        self.present(MainMediaPlayerViewController(), animated: true, completion: nil)
    }
    
    @objc private func contentAddOrRemoveFav() {
        if let userData = UserPresenter.sharedIntance.getUserData() {
            userData.userFavList?.append(mainContentPresenter.mainContentSelected.contentID)
            UserPresenter.sharedIntance.saveUser(userIn: userData)
        }else {
            self.present(LoginViewController(), animated: true, completion: nil)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch detailSection.allCases[indexPath.row] {
            
        case .DetailCoverCell:
            
            let detailCoverCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailCoverCell.rawValue) as! DetailCoverCellTableViewCell
            detailCoverCell.setupCell(contentIn: mainContentPresenter.mainContentSelected)
            return detailCoverCell
            
        case .DetailActionBtnCell:
            
            let detailActionBtnCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailActionBtnCell.rawValue) as!
            DetailActionBtnTableViewCell
            
            detailActionBtnCell.mainActionBtn.addTarget(self, action: #selector(contentPlayMedia), for: .touchUpInside)
            detailActionBtnCell.actionFavBtn.addTarget(self, action: #selector(contentAddOrRemoveFav), for: .touchUpInside)
            
            return detailActionBtnCell
            
        case .DetailSinoxisCell:
            
            let detailSinoxisCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailSinoxisCell.rawValue) as! DetailSinoxisTableViewCell
            detailSinoxisCell.setupCell(contentIn: mainContentPresenter.mainContentSelected)
            sinoxisH = detailSinoxisCell.sinoxisLb.frame.height + 30
            return detailSinoxisCell
            
        case .DetailRatingCell:
            
            let detailRatingCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailRatingCell.rawValue) as! DetailRatingTableViewCell
            detailRatingCell.setupCell(contentIn: mainContentPresenter.mainContentSelected)
            return detailRatingCell
            
        case .DetailCastCell:
            
            let detailCastCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailCastCell.rawValue) as! DetailCastTableViewCell
            detailCastCell.setupCell(contentIn: mainContentPresenter.mainContentSelected)
            return detailCastCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch detailSection.allCases[indexPath.row] {
        case .DetailCoverCell:
            return 300.0
        case .DetailActionBtnCell:
            return 80.0
        case .DetailSinoxisCell:
            return sinoxisH
        case .DetailRatingCell:
            return 100.0
        case .DetailCastCell:
            return 200.0
        }
    }
}
