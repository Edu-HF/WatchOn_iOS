//
//  SerieDetailTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo  Herrera Fagundez on 26/09/19.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class SerieDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mSintaxisLB: UITextView!
    @IBOutlet weak var mLanIMG: UIImageView!
    @IBOutlet weak var mRatingNumLB: UILabel!
    @IBOutlet weak var mFavBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        mSintaxisLB.text = ""
        mLanIMG.image = nil
        mRatingNumLB.text = ""
    }

    func setupCell() {
        let serieDetail = SerieContentPresenter.sharedInstance.mainSerieContentSelected.value
        
        mSintaxisLB.text = serieDetail.serieSintaxis
        mRatingNumLB.text = String(serieDetail.serieVoteAverage ?? 0.0)
        
        if UserPresenter.sharedIntance.isSerieFav(sContentIn: serieDetail) {
            mFavBtn.setImage(UIImage(named: "FavOn_IC"), for: .normal)
        }else {
            mFavBtn.setImage(UIImage(named: "FavOff_IC"), for: .normal)
        }
    }
    
    @IBAction func addOrRemoveFavAct(_ sender: Any) {
        let userPresenter = UserPresenter.sharedIntance
        if userPresenter.isSerieFav(sContentIn: SerieContentPresenter.sharedInstance.mainSerieContentSelected.value) {
            if userPresenter.removeSerieContentToFav(sContentIn: SerieContentPresenter.sharedInstance.mainSerieContentSelected.value) {
                self.mFavBtn.setImage(UIImage(named: "FavOff_IC"), for: .normal)
            }else {
                NotificationCenter.default.post(name: .ShowLoginVCNoti, object: nil)
            }
        }else {
            if userPresenter.addSerieContentToFav(sContentIn: SerieContentPresenter.sharedInstance.mainSerieContentSelected.value) {
                self.mFavBtn.setImage(UIImage(named: "FavOn_IC"), for: .normal)
            }else {
                NotificationCenter.default.post(name: .ShowLoginVCNoti, object: nil)
            }
        }
    }
}
