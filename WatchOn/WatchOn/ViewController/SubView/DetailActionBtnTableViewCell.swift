//
//  DetailActionBtnTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 31/08/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class DetailActionBtnTableViewCell: UITableViewCell {

    @IBOutlet weak var mainActionBtn: WButton!
    @IBOutlet weak var actionFavBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func setupView() {
        if ContentPresenter.sharedIntance.isItemsFav() {
            actionFavBtn.setImage(UIImage(named: "FavOn_IC"), for: .normal)
        }else {
            actionFavBtn.setImage(UIImage(named: "FavOff_IC"), for: .normal)
        }
    }
}
