//
//  DetailViewController.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

private enum detailSection: String, CaseIterable {
    case DetailCoverCell, DetailSinoxisCell, DetailRatingCell, DetailCastCell
}

class DetailViewController: BaseViewController {

    @IBOutlet weak var detailTV: UITableView!
    private lazy var sinoxisH: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        setVCTitle(titleIn: "Detail")
        detailTV.register(UINib(nibName: "DetailCoverCell", bundle: nil), forCellReuseIdentifier: "DetailCoverCell")
        detailTV.register(UINib(nibName: "DetailSinoxisCell", bundle: nil), forCellReuseIdentifier: "DetailSinoxisCell")
        detailTV.register(UINib(nibName: "DetailRatingCell", bundle: nil), forCellReuseIdentifier: "DetailRatingCell")
        detailTV.register(UINib(nibName: "DetailCastCell", bundle: nil), forCellReuseIdentifier: "DetailCastCell")
        detailTV.estimatedRowHeight = 400
        detailTV.rowHeight = UITableView.automaticDimension
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
            return detailCoverCell
            
        case .DetailSinoxisCell:
            
            let detailSinoxisCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailSinoxisCell.rawValue) as! DetailSinoxisTableViewCell

            sinoxisH = detailSinoxisCell.sinoxisLb.frame.height + 30
            return detailSinoxisCell
            
        case .DetailRatingCell:
            
            let detailRatingCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailRatingCell.rawValue) as! DetailRatingTableViewCell
            return detailRatingCell
            
        case .DetailCastCell:
            
            let detailCastCell = tableView.dequeueReusableCell(withIdentifier: detailSection.DetailCastCell.rawValue) as! DetailCastTableViewCell
            return detailCastCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch detailSection.allCases[indexPath.row] {
        case .DetailCoverCell:
            return 300.0
        case .DetailSinoxisCell:
            return sinoxisH
        case .DetailRatingCell:
            return 100.0
        case .DetailCastCell:
            return 200.0
        }
    }
}
