//
//  DetailRatingTableViewCell.swift
//  WatchOn
//
//  Created by Eduardo Herrera on 10/07/2019.
//  Copyright © 2019 ezCode. All rights reserved.
//

import UIKit

class DetailRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseDateLB: UILabel!
    @IBOutlet weak var averageNumLB: UILabel!
    @IBOutlet weak var voteBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var sharedBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        releaseDateLB.text = ""
        averageNumLB.text = ""
    }
    
    func setupCell(contentIn: Content) {
        
        releaseDateLB.text = "ReleaseDateKey".localized() + (contentIn.contentReleaseDate ?? "")
        averageNumLB.text = String(contentIn.contentVoteAverage ?? 0)
    }

}
